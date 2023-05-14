import cv2

input_img = cv2.imread('./data/sample_cat_01.jpg')
output_img = cv2.resize(input_img, dsize=(100, 100))
cv2.imwrite('output.jpg', output_img)