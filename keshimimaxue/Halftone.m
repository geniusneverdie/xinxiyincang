function [im_out] = Halftone(im_gray)

% 定义点阵单元尺寸和比例因子
% cell_size = 8;  % 点阵单元尺寸
scale_factor = 255;  % 比例因子

% 初始化输出图像和误差矩阵
im_out = zeros(size(im_gray),'uint8');

% 执行误差扩散算法
for i = 1:size(im_gray, 1)
    for j = 1:size(im_gray, 2)
        % 计算当前像素值和最近的阈值
        old_gray = im_gray(i, j);
        new_gray = round(old_gray / scale_factor) * scale_factor;
        im_out(i, j) = new_gray;
        
        % 计算误差并进行扩散
        quant_error = old_gray - new_gray ;
        if j < size(im_gray, 2)
            im_gray(i, j+1) = im_gray(i, j+1) + quant_error * 7 / 16;
        end
        if i < size(im_gray, 1) && j > 1
            im_gray(i+1, j-1) = im_gray(i+1, j-1) + quant_error * 3 / 16;
        end
        if i < size(im_gray, 1)
            im_gray(i+1, j) = im_gray(i+1, j) + quant_error * 5 / 16;
        end
        if i < size(im_gray, 1) && j < size(im_gray, 2)
            im_gray(i+1, j+1) = im_gray(i+1, j+1) + quant_error * 1 / 16;
        end
    end
end

