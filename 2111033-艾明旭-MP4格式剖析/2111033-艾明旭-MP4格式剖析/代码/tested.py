from scipy.fftpack import dct, idct
import cv2
import numpy as np

def bin_to_message(binary_str):
    message = []
    # 确保完全按每8位解析字符，如果遇到停止标记则立刻停止
    for i in range(0, len(binary_str) - 8, 8):  # 减8是为了避免超出索引
        byte = binary_str[i:i+8]
        if byte == '11111110':  # 停止标记
            return ''.join(message)
        message.append(chr(int(byte, 2)))
    return ''.join(message)


def message_to_bin(message):
    return ''.join(format(ord(char), '08b') for char in message)

def dct_hide_message(frame, message):
    message_binary = message_to_bin(message) + '1111111111111110'  # 添加停止标记
    index = 0
    height, width = frame.shape[:2]
    for i in range(0, height - 8, 8):
        for j in range(0, width - 8, 8):
            block = frame[i:i+8, j:j+8, 0]  # 取蓝色通道
            dct_block = dct(dct(block.T, norm='ortho').T, norm='ortho')

            # 在DCT系数中隐藏信息
            if index < len(message_binary):
                base_value = np.floor(dct_block[5][5] / 100) * 100
                dct_block[5][5] = base_value + int(message_binary[index]) * 50  # 嵌入信息
                index += 1
                if index == len(message_binary):
                    frame[i:i+8, j:j+8, 0] = idct(idct(dct_block, norm='ortho').T, norm='ortho').T
                    return frame
            frame[i:i+8, j:j+8, 0] = idct(idct(dct_block, norm='ortho').T, norm='ortho').T
    return frame


def dct_extract_message(frame):
    binary_str = ''
    height, width = frame.shape[:2]
    for i in range(0, height - 8, 8):
        for j in range(0, width - 8, 8):
            block = frame[i:i+8, j:j+8, 0]
            dct_block = dct(dct(block.T, norm='ortho').T, norm='ortho')
            coeff_value = dct_block[5][5]
            bit = '1' if np.round(coeff_value % 100) > 25 else '0'
            binary_str += bit

            if len(binary_str) >= 16 and binary_str[-16:] == '1111111111111110':
                return bin_to_message(binary_str[:-16])
    return bin_to_message(binary_str)



cap = cv2.VideoCapture('input.mp4')
ret, frame = cap.read()  # 读取第一帧
cap.release()

cv2.imshow('DCT Original Frame', frame)
cv2.waitKey(0)
cv2.destroyAllWindows()

# 对修改后的第一个帧使用DCT隐写
secret_message = "Hello, this is a hidden message!"
frame = dct_hide_message(frame, secret_message)

extracted_message = dct_extract_message(frame)
print("Extracted Message:", extracted_message)

# 显示DCT修改后的帧
cv2.imshow('DCT Modified Frame', frame)
cv2.waitKey(0)
cv2.destroyAllWindows()