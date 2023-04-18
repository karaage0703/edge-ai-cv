import argparse
import numpy as np
import cv2
import sys
import time
import os
import onnxruntime


if __name__ == '__main__':
    # parse options
    parser = argparse.ArgumentParser(description='onnx')
    parser.add_argument('-m', '--model', default='./model/janken.onnx')
    parser.add_argument('-l', '--labels', default='./model/label.txt')

    args = parser.parse_args()

    labels = []
    with open(args.labels,'r') as f:
        for line in f:
            labels.append(line.rstrip())
    NUM_CLASSES = len(labels)
    print(labels)

    onnx_session = onnxruntime.InferenceSession(args.model)

    cam = cv2.VideoCapture(0)

    count_max = 0
    count = 0

    while True:
        ret, capture = cam.read()
        if not ret:
            print('error')
            break
        key = cv2.waitKey(1)
        if key == 27: # when ESC key is pressed break
            break

        count += 1
        if count > count_max:
            # image convert
            image = capture.copy()
            image = cv2.resize(image, (64, 64))
            image = image.reshape(-1, 64, 64, 3)
            image = image.transpose(0, 3, 1, 2)
            image = image.astype('float32')/255.0

            start = time.time()

            # Inference
            input_name = onnx_session.get_inputs()[0].name
            output_name = onnx_session.get_outputs()[0].name
            output = onnx_session.run([output_name], {input_name: image})

            preds = np.argmax(output[0][0])
            elapsed_time = time.time() - start

            pred_label = labels[preds]

            # Put speed
            speed_info = '%s: %f' % ('speed=', elapsed_time)
            cv2.putText(capture, speed_info , (10,50), \
              cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 255), 1, cv2.LINE_AA)

            # Put label
            cv2.putText(capture, pred_label, (10,100), \
              cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 255), 1, cv2.LINE_AA)

            cv2.imshow('pytorchi inspector', capture)
            count = 0

    cam.release()
    cv2.destroyAllWindows()
