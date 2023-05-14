import cv2

input_img = cv2.imread('./data/sample_cat_02.jpg')
output_img = input_img[0:300, 0:500, :]
cv2.imwrite('output.jpg', output_img)
