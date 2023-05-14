import cv2

input_img = cv2.imread('./data/sample_cat_01.jpg')
output_img = input_img[:, :, ::-1]
# output_img = cv2.cvtColor(input_img, cv2.COLOR_BGR2RGB)
cv2.imwrite('output.jpg', output_img)
