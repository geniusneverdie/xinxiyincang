import cv2
import numpy as np


def message_to_bin(message):
    return ''.join(format(ord(char), '08b') for char in message)


def hide_message_in_frame(frame, message):
    n_bytes = frame.shape[0] * frame.shape[1] * 3 // 8
    if len(message) > n_bytes:
        raise ValueError("Error: Insufficient bytes, need bigger frame or less data.")

    message_binary = message_to_bin(message) + '1111111111111110'  # 添加停止标记
    index = 0
    for i in range(frame.shape[0]):
        for j in range(frame.shape[1]):
            for k in range(3):  # 遍历每个像素的RGB通道
                if index < len(message_binary):
                    frame[i, j, k] = int(bin(frame[i, j, k])[2:-1] + message_binary[index], 2)
                    index += 1
                if index == len(message_binary):
                    return frame
    return frame

def bin_to_message(binary_str):
    message = []
    # 确保完全按每8位解析字符，如果遇到停止标记则立刻停止
    for i in range(0, len(binary_str) - 8, 8):  # 减8是为了避免超出索引
        byte = binary_str[i:i+8]
        if byte == '11111110':  # 停止标记
            return ''.join(message)
        message.append(chr(int(byte, 2)))
    return ''.join(message)

def extract_message_from_frame(frame):
    binary_str = ''
    for i in range(frame.shape[0]):
        for j in range(frame.shape[1]):
            for k in range(3):  # 遍历每个像素的RGB通道
                binary_str += bin(frame[i, j, k])[-1]  # 提取最低有效位
                if len(binary_str) >= 8:
                    last_byte = binary_str[-8:]  # 每次检查最新的8位
                    if last_byte == '11111110':  # 检查停止标记
                        return bin_to_message(binary_str[:-8])  # 返回结果，排除停止标记
    return bin_to_message(binary_str)  # 如果没有找到停止标记，返回整个消息


# 读取视频
cap = cv2.VideoCapture('input.mp4')
ret, frame = cap.read()  # 读取第一帧
cap.release()

cv2.imshow('Original Frame', frame)
cv2.waitKey(0)

# 隐藏信息
secret_message = "Hello, this is a hidden message!"
frame = hide_message_in_frame(frame, secret_message)

# 展示修改后的帧
cv2.imshow('Modified Frame', frame)
cv2.waitKey(0)
cv2.destroyAllWindows()

# 使用前面修改过的帧
extracted_message = extract_message_from_frame(frame)
print("Extracted Message:", extracted_message)


