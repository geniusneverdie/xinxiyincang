%图像处理
pic='lena.bmp'
[L,M]=imread(pic);
[height,width]=size(L);%获取原图像大小
width=width/3;
figure(1);
figure('color',[1 1 1]);
subplot(1,2,1);imshow(L);title('原图');
%半色调处理
for t=1:3
    for i=1: height
        for j=1: width
            if L(i,j,t)>127
                out=255;
            else
                out=0;
            end
            error=L(i,j)-out;
            if j>1 && i<height && j<width
                L(i,j+1,t)=L(i,j+1,t)+error*7/16.0;%右方
                L(i+1,j,t)=L(i+1,j,t)+error*5/16.0;%下方
                L(i+1,j-1,t)=L(i+1,j-1,t)+error*3/16.0;%左下方
                L(i+1,j+1,t)=L(i+1,j+1,t)+error*1/16.0;%右下方
                L(i,j,t)=out;
            else
                L(i,j,t)=out;
            end
        end
    end
end
set(0,'defaultfigurecolor','w')
subplot(1,2,2);imshow(L);title('半色调处理');  
%随机生成 A,B 子图矩阵，初始值为0，即为全黑图像
red=L(:,:,1);
green=L(:,:,2);
blue=L(:,:,3);
sub_height=2*height;sub_width=2*width;
subA=zeros(sub_height,sub_width);%初始化子图A
subB=zeros(sub_height,sub_width);
subC=zeros(sub_height,sub_width);

%原图放入三张子图
for t=1:3
    for i=1: height
        for j=1: width
            if(L(i,j,t)==255)%原图是白像素
                random= round(rand()*3);
                switch random
                    case 0
                        subA(2*i,2*j,t)=0;subA(2*i+1,2*j,t)=1;
                        subA(2*i,2*j+1,t)=0;subA(2*i+1,2*j+1,t)=1;
                        subB(2*i,2*j,t)=1;subB(2*i+1,2*j,t)=1;
                        subB(2*i,2*j+1,t)=0;subB(2*i+1,2*j+1,t)=0;
                        subC(2*i,2*j,t)=0;subC(2*i+1,2*j,t)=1;
                        subC(2*i,2*j+1,t)=1;subC(2*i+1,2*j+1,t)=0;
                    case 1
                        subA(2*i,2*j,t)=0;subA(2*i+1,2*j,t)=0;
                        subA(2*i,2*j+1,t)=1;subA(2*i+1,2*j+1,t)=1;
                        subB(2*i,2*j,t)=0;subB(2*i+1,2*j,t)=1;
                        subB(2*i,2*j+1,t)=1;subB(2*i+1,2*j+1,t)=0;
                        subC(2*i,2*j,t)=1;subC(2*i+1,2*j,t)=0;
                        subC(2*i,2*j+1,t)=1;subC(2*i+1,2*j+1,t)=0;
                    case 2
                        subA(2*i,2*j,t)=1;subA(2*i+1,2*j,t)=0;
                        subA(2*i,2*j+1,t)=1;subA(2*i+1,2*j+1,t)=0;
                        subB(2*i,2*j,t)=1;subB(2*i+1,2*j,t)=0;
                        subB(2*i,2*j+1,t)=0;subB(2*i+1,2*j+1,t)=1;
                        subC(2*i,2*j,t)=1;subC(2*i+1,2*j,t)=1;
                        subC(2*i,2*j+1,t)=0;subC(2*i+1,2*j+1,t)=0;
                    case 3
                        subA(2*i,2*j,t)=1;subA(2*i+1,2*j,t)=0;
                        subA(2*i,2*j+1,t)=0;subA(2*i+1,2*j+1,t)=1;
                        subB(2*i,2*j,t)=0;subB(2*i+1,2*j,t)=0;
                        subB(2*i,2*j+1,t)=1;subB(2*i+1,2*j+1,t)=1;
                        subC(2*i,2*j,t)=0;subC(2*i+1,2*j,t)=1;
                        subC(2*i,2*j+1,t)=0;subC(2*i+1,2*j+1,t)=1;
                end
            end
            if(L(i,j,t)==0)%原图是黑像素
                random= round(rand()*3);
                switch random
                    case 0
                        subA(2*i,2*j,t)=0;subA(2*i+1,2*j,t)=1;
                        subA(2*i,2*j+1,t)=0;subA(2*i+1,2*j+1,t)=1;
                        subB(2*i,2*j,t)=1;subB(2*i+1,2*j,t)=1;
                        subB(2*i,2*j+1,t)=0;subB(2*i+1,2*j+1,t)=0;
                        subC(2*i,2*j,t)=1;subC(2*i+1,2*j,t)=0;
                        subC(2*i,2*j+1,t)=0;subC(2*i+1,2*j+1,t)=1;
                    case 1
                        subA(2*i,2*j,t)=0;subA(2*i+1,2*j,t)=0;
                        subA(2*i,2*j+1,t)=1;subA(2*i+1,2*j+1,t)=1;
                        subB(2*i,2*j,t)=0;subB(2*i+1,2*j,t)=1;
                        subB(2*i,2*j+1,t)=0;subB(2*i+1,2*j+1,t)=1;
                        subC(2*i,2*j,t)=0;subC(2*i+1,2*j,t)=1;
                        subC(2*i,2*j+1,t)=1;subC(2*i+1,2*j+1,t)=0;
                    case 2
                        subA(2*i,2*j,t)=1;subA(2*i+1,2*j,t)=0;
                        subA(2*i,2*j+1,t)=1;subA(2*i+1,2*j+1,t)=0;
                        subB(2*i,2*j,t)=0;subB(2*i+1,2*j,t)=1;
                        subB(2*i,2*j+1,t)=1;subB(2*i+1,2*j+1,t)=0;
                        subC(2*i,2*j,t)=1;subC(2*i+1,2*j,t)=1;
                        subC(2*i,2*j+1,t)=0;subC(2*i+1,2*j+1,t)=0;
                    case 3
                        subA(2*i,2*j,t)=1;subA(2*i+1,2*j,t)=0;
                        subA(2*i,2*j+1,t)=0;subA(2*i+1,2*j+1,t)=1;
                        subB(2*i,2*j,t)=1;subB(2*i+1,2*j,t)=0;
                        subB(2*i,2*j+1,t)=1;subB(2*i+1,2*j+1,t)=0;
                        subC(2*i,2*j,t)=0;subC(2*i+1,2*j,t)=0;
                        subC(2*i,2*j+1,t)=1;subC(2*i+1,2*j+1,t)=1;
                end
            end
        end
    end
end
figure(2);
figure('color',[1 1 1]);
set(0,'defaultfigurecolor','w')
subplot(3,3,1);imshow(subA);title('子图1');
subplot(3,3,2);imshow(subB);title('子图2');
subplot(3,3,3);imshow(subC);title('子图3');
%相与操作
recoverylarge=zeros(2*height+1,2*width+1);%初始化缩小后的复原图
recoverylargeAB=zeros(2*height+1,2*width+1);%初始化缩小后的复原图
recoverylargeAC=zeros(2*height+1,2*width+1);%初始化缩小后的复原图
recoverylargeBC=zeros(2*height+1,2*width+1);%初始化缩小后的复原图

for t=1:3
    for i=1: 2*height
        for j=1: 2*width
            recoverylarge(i,j,t)=subA(i,j,t)&& subB(i,j,t)&&subC(i,j,t);
            recoverylargeAB(i,j,t)=subA(i,j,t)&& subB(i,j,t);
            recoverylargeAC(i,j,t)=subA(i,j,t)&& subC(i,j,t);
            recoverylargeBC(i,j,t)=subB(i,j,t)&& subC(i,j,t);
        end
    end
end
set(0,'defaultfigurecolor','w')
subplot(3,3,4);imshow(recoverylargeAB);title('12合并');
subplot(3,3,5);imshow(recoverylargeAC);title('13合并');
subplot(3,3,6);imshow(recoverylargeBC);title('23合并');
subplot(3,3,7);imshow(recoverylarge);title('合并后的复原图');

%缩小清晰化处理
recovery=zeros(height,width);%初始化复原图
for t=1:3
    for i=1: height
        for j=1: width
            if(recoverylarge(2*i,2*j,t)==1||recoverylarge(2*i+1,2*j,t)==1||recoverylarge(2*i,2*j+1,t)==1||recoverylarge(2*i+1,2*j+1,t)==1)
                recovery(i,j,t)=1;
            else
                recovery(i,j,t)=0;
            end
        end
    end
end
set(0,'defaultfigurecolor','w')
subplot(3,3,8);imshow(recovery);title('缩小清晰化处理后的复原图');