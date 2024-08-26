% Load the input image
input_img = imread('lena.bmp');
% Convert to grayscale
im = rgb2gray(input_img); 
%%%%%%%%%%%%%%%%%%%%半色调化处理%%%%%%%%%%%%%%%%%%%
% Initialize input image B and output image I
K = im;
I = zeros(size(K));
[height,width]=size(K);
% Define error distribution weights
a = 7/16;
b = 3/16;
c = 5/16;
d = 1/16;

% Process each pixel in the image
for i = 1:width
    for j = 1:height
        if K(i,j) > 127
            I(i,j) = 255;
        else
            I(i,j) = 0;
        end
        error = (K(i,j) - I(i,j));
        if j > 1 && j < height && i < width
            K(i,j+1) = K(i,j+1) + error * a;
            K(i+1,j-1) = K(i+1,j-1) + error * b;
            K(i+1,j) = K(i+1,j) + error * c;
            K(i+1,j+1) = K(i+1,j+1) + error * d;
        end
    end
end
% Convert to binary image 二值化处理
im_bin = imbinarize(im);
% Display the output image
figure(1);
subplot(1,2,1);imshow(I);title("半色调化处理的图像");
subplot(1,2,2);imshow(im_bin);title("二值化处理的图像");

%%%%%%%%%%%%%%%%%生成子秘密图片A，B，C%%%%%%%%%%%%%%
A = rand(width,height);
B = rand(width,height);
C = rand(width,height);
for i=1: height
    for j=1: width
        if(I(i,j)==0) % 黑色像素 opaque
            random=rand()*16;
            if(random>0&&random<5)
                A(i,j)=1;A(i+1,j)=0;A(i+2,j)=0;
                B(i,j)=0;B(i+1,j)=1;B(i+2,j)=0;
                C(i,j)=0;C(i+1,j)=0;C(i+2,j)=1;
            end
            if(random>1&&random<10)
                A(i,j)=0;A(i+1,j)=1;A(i+2,j)=0;
                B(i,j)=0;B(i+1,j)=0;B(i+2,j)=1;
                C(i,j)=1;C(i+1,j)=0;C(i+2,j)=0;
            else
                A(i,j)=0;A(i+1,j)=0;A(i+2,j)=1;
                B(i,j)=1;B(i+1,j)=0;B(i+2,j)=0;
                C(i,j)=0;C(i+1,j)=1;C(i+2,j)=0;
            end
        end
        if (I(i,j)==1)% 白色像素 transparent
             random=rand()*16;
             if(random>0&&random<5)
                A(i,j)=1;A(i+1,j)=0;A(i+2,j)=0;
                B(i,j)=1;B(i+1,j)=0;B(i+2,j)=0;
                C(i,j)=1;C(i+1,j)=0;C(i+2,j)=0;
            end
            if(random>1&&random<10)
                A(i,j)=0;A(i+1,j)=1;A(i+2,j)=0;
                B(i,j)=0;B(i+1,j)=1;B(i+2,j)=0;
                C(i,j)=0;C(i+1,j)=1;C(i+2,j)=0;
            else
                A(i,j)=0;A(i+1,j)=0;A(i+2,j)=1;
                B(i,j)=0;B(i+1,j)=0;B(i+2,j)=1;
                C(i,j)=0;C(i+1,j)=0;C(i+2,j)=1;
            end
        end
    end
end
figure(2);
subplot(1,3,1); imshow(A); title('子秘密A');
subplot(1,3,2); imshow(B); title('子秘密B');
subplot(1,3,3); imshow(C); title('子秘密C');

% decoding the secret by superimposing the collected share images again
D1=and(A,B);
D2=and(B,C);
D3=and(A,C);
D=and(and(A,B),C);
figure(3);
subplot(2,2,1);imshow(D1);title("A⋁B");
subplot(2,2,2);imshow(D2);title("B⋁C");
subplot(2,2,3);imshow(D3);title("A⋁C");
subplot(2,2,4);imshow(D);title("A⋁B⋁C");
