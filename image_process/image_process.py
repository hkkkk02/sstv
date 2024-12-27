# from PIL import Image, ImageDraw

# # 创建画布
# width = 320
# height = 256
# img = Image.new('RGB', (width, height), 'black')
# draw = ImageDraw.Draw(img)

# # 第一行颜色
# colors_top = ['#7F7F7F', '#FFFFFF', '#FFFF00', '#00FFFF', '#00FF00', '#FF00FF', '#FF0000', '#0000FF']
# bar_width = width // 8
# for i in range(8):
#     x1 = i * bar_width
#     x2 = (i + 1) * bar_width
#     draw.rectangle([(x1, 0), (x2, 100)], fill=colors_top[i])

# # 第二行渐变
# for x in range(width):
#     gray = int(x / width * 255)
#     color = (gray, gray, gray)
#     draw.line([(x, 100), (x, 150)], fill=color)

# # 第三行黑白相间
# colors_bottom = ['#000000', '#FFFFFF'] * 4
# for i in range(8):
#     x1 = i * bar_width
#     x2 = (i + 1) * bar_width
#     draw.rectangle([(x1, 150), (x2, 256)], fill=colors_bottom[i])

# img.save('color_test.png')

import cv2
import numpy as np

import os
os.chdir(os.path.dirname(os.path.realpath(__file__)))

# 读取图片
img = cv2.imread('../resources/20241227-2307_SSTV-color-test.png')

# 分离RGB通道
b, g, r = cv2.split(img)

# 创建三张单通道图片
r_img = np.zeros_like(img)
g_img = np.zeros_like(img)
b_img = np.zeros_like(img)

# 为每个通道赋值
r_img[:,:,2] = r
g_img[:,:,1] = g  
b_img[:,:,0] = b

# 保存三张分量图片
cv2.imwrite('../resources/20241227-2307_SSTV-color-test_R.png', r_img)
cv2.imwrite('../resources/20241227-2307_SSTV-color-test_G.png', g_img) 
cv2.imwrite('../resources/20241227-2307_SSTV-color-test_B.png', b_img)