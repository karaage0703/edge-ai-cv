import cv2

input_img = cv2.imread('./data/sample_cat_02.jpg')

cv2.rectangle(input_img,
    pt1=(0, 0),
    pt2=(500, 300),
    color=(0, 0, 255),
    thickness=2
)

cv2.putText(input_img,
            text='cat',
            org=(500, 300),
            fontFace=cv2.FONT_HERSHEY_SIMPLEX,
            fontScale=1.0,
            color=(0, 0, 255),
            thickness=2
)

cv2.imwrite('output.jpg', input_img)
