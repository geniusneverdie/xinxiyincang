x=imread('C:\Users\PC\Desktop\lena.png');%读取图像文件的像素值存入矩阵中
%将图像的分辨率调为 256x256
y=imresize(x, [256, 256]);%imresize 函数调整图像文件分辨率
disp(size(x));%输出原始图像文件的长、宽
disp(size(y));%输出调整大小后的图片的长、宽
I=rgb2gray(y);%将彩色图像处理为灰度图像
a=imbinarize(I);%将灰度图像处理为二值图像，即黑白图像
figure;
imshow(x);title('原始图片');
imshow(y);title('调整大小后的图片');
imshow(a);title('二值化后的图片');
[~,~]=size(a);
disp(size(a));
A=zeros(512,512);
B=zeros(512,512);
[height,width]=size(A);
% 随机生成 A、B 矩阵，大小为二值化后的原图的四倍，作为子图像，然后初始化A、B像素矩阵
for i=1: height
    for j=1: width
        random=rand()*2;
            if(random>1)
                A(i,j)=1;B(i,j)=1;
            else
                A(i,j)=0;B(i,j)=0;
            end
    end
end
%利用信息分存原理进行分存，分存时一共有八种情况，直接将原图的黑白像素进行扩展
[height,width]=size(a);
for i=1: height
    for j=1: width
        if(a(i,j)==0)%纯黑
            random=rand()*4;
            if(random>0&&random<=1)
                A(2*i-1,2*j-1)=1;A(2*i-1,2*j)=0;A(2*i,2*j-1)=0;A(2*i,2*j)=0;
                B(2*i-1,2*j-1)=0;B(2*i-1,2*j)=0;B(2*i,2*j-1)=0;B(2*i,2*j)=1;
            end
            if(random>1&&random<=2)
                A(2*i-1,2*j-1)=1;A(2*i-1,2*j)=1;A(2*i,2*j-1)=0;A(2*i,2*j)=0;
                B(2*i-1,2*j-1)=0;B(2*i-1,2*j)=0;B(2*i,2*j-1)=1;B(2*i,2*j)=1;
            end
            if(random>3&&random<4)
                A(2*i-1,2*j-1)=1;A(2*i-1,2*j)=1;A(2*i,2*j-1)=0;A(2*i,2*j)=0;
                B(2*i-1,2*j-1)=0;B(2*i-1,2*j)=0;B(2*i,2*j-1)=0;B(2*i,2*j)=1;
            end
            if(random>2&&random<=3)
                A(2*i-1,2*j-1)=0;A(2*i-1,2*j)=0;A(2*i,2*j-1)=0;A(2*i,2*j)=1;
                B(2*i-1,2*j-1)=1;B(2*i-1,2*j)=1;B(2*i,2*j-1)=0;B(2*i,2*j)=0;
            end
        end
        if(a(i,j)==1)%纯白
            random=rand()*4;
            if(random>0&&random<=1)
                A(2*i-1,2*j-1)=0;A(2*i-1,2*j)=1;A(2*i,2*j-1)=0;A(2*i,2*j)=0;
                B(2*i-1,2*j-1)=0;B(2*i-1,2*j)=1;B(2*i,2*j-1)=0;B(2*i,2*j)=0;
            end
            if(random>1&&random<=2)
                A(2*i-1,2*j-1)=1;A(2*i-1,2*j)=1;A(2*i,2*j-1)=0;A(2*i,2*j)=0;
                B(2*i-1,2*j-1)=0;B(2*i-1,2*j)=1;B(2*i,2*j-1)=0;B(2*i,2*j)=1;
            end
            if(random>2&&random<=3)
                A(2*i-1,2*j-1)=1;A(2*i-1,2*j)=1;A(2*i,2*j-1)=0;A(2*i,2*j)=0;
                B(2*i-1,2*j-1)=0;B(2*i-1,2*j)=1;B(2*i,2*j-1)=0;B(2*i,2*j)=0;
            end
            if(random>3&&random<4)
                A(2*i-1,2*j-1)=0;A(2*i-1,2*j)=1;A(2*i,2*j-1)=0;A(2*i,2*j)=0;
                B(2*i-1,2*j-1)=1;B(2*i-1,2*j)=1;B(2*i,2*j-1)=0;B(2*i,2*j)=0;
            end
        end
    end
end
imwrite(A,'C:\Users\PC\Desktop\a.png','png');
imwrite(B,'C:\Users\PC\Desktop\b.png','png');
figure;
imshow(A);title('子密钥1');
imshow(B);title('子密钥2');
%将分存的两个子图通过相与合并为放大四倍的原图
I=and(A,B);
figure;
imshow(I);title('合并后的四倍大小的中等灰度原图');
%对上个结果进行缩放处理得到原图
V=zeros(256,256);
for i=1:height
    for j=1:width
        if((I(2*i-1,2*j-1)==1)||(I(2*i-1,2*j)==1)||(I(2*i,2*j-1)==1)||(I(2*i,2*j)==1))
            V(i,j)=1;
        end
    end
end
figure;
imshow(V);title('经过缩放得到的原图');