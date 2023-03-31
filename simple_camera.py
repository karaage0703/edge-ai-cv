import cv2
cap = cv2.VideoCapture(0)

while True:
    ret, frame = cap.read()
    if not ret:
        break

    key = cv2.waitKey(1)
    if key == 27:  # when ESC key is pressed break
        break

    cv2.imshow('camera', frame)

cap.release()
cv2.destroyAllWindows()
