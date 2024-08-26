import cv2
import numpy as np

# 嵌入信息函数
def embed_message(frame1, frame2, message):
    binary_message = ''.join(format(ord(char), '08b') for char in message)
    index = 0
    for i in range(frame1.shape[0]):
        for j in range(frame1.shape[1]):
            if index < len(binary_message):
                diff = int(binary_message[index]) * 10  # 使用10作为差异基数
                frame2[i, j, 0] = frame1[i, j, 0] + diff
                index += 1
            else:
                break
    return frame2

# 提取信息函数
def extract_message(frame1, frame2):
    binary_message = ''
    for i in range(frame1.shape[0]):
        for j in range(frame1.shape[1]):
            diff = frame2[i, j, 0] - frame1[i, j, 0]
            bit = '1' if diff > 5 else '0'
            binary_message += bit
            if len(binary_message) >= 8 and binary_message[-8:] == '00000000':
                break
        else:
            continue
        break
    message = ''.join(chr(int(binary_message[i:i+8], 2)) for i in range(0, len(binary_message) - 8, 8))
    return message

# 读取视频
cap = cv2.VideoCapture('input.mp4')
ret, frame1 = cap.read()
ret, frame2 = cap.read()

# 隐藏信息
secret_message = "Hello, this is a hidden message!"
modified_frame = embed_message(frame1, frame2, secret_message)

cv2.imshow('Frame 1', frame1)
cv2.imshow('Frame 2', modified_frame)
cv2.waitKey(0)  # 等待按键
cv2.destroyAllWindows()

# 写入修改后的视频
fourcc = cv2.VideoWriter_fourcc(*'mp4v')
out = cv2.VideoWriter('output.mp4', fourcc, 20.0, (frame1.shape[1], frame1.shape[0]))

# 添加帧到输出视频
out.write(frame1)
out.write(modified_frame)

# 读取更多帧并添加到视频
while True:
    ret, frame = cap.read()
    if not ret:
        break
    out.write(frame)

# 清理资源
cap.release()
out.release()

# 提取信息测试
print("Extracted Message:", extract_message(frame1, modified_frame))
