# 信息隐藏技术第二次实验 —— `图像信号处理`

> **学号：2111033  
> 姓名：艾明旭 
> 专业：信息安全**

## 一、实验原理和常用语音处理算法简介

---

### **1、二维傅立叶变换与短时傅立叶变换**

![](C:\Users\86151\AppData\Roaming\marktext\images\2024-03-20-10-23-07-image.png)

而语音信号等具有很强的时变性，在一段时间内呈现出周期性信号的特点，而在另一段时间内呈现出随机信号的特点，或者呈现出两个混合的特性。对于频谱随时间变化的确定性信号以及非平稳随机信号，利用傅里叶变换分析方法有很大的局限性。傅里叶变换无法针对性地分析相应时间区域内信号的频率特征，需要用一个窗函数与时间信号相乘积，当该窗函数的时宽足够窄，使取出的信号可以被看成是平稳信号时，就可以对乘积信号进行傅里叶变换，从而反映该时宽中的信号频谱变化规律。

### **2、二维离散小波变换**

![](C:\Users\86151\AppData\Roaming\marktext\images\2024-03-20-10-23-13-image.png)

小波变换继承和发展了短时傅里叶变换局部化的思想，同时又克服了窗口大小不随频率变化等缺点，能够提供一个随频率改变的“时间-频率”窗口，是进行信号时频分析和处理的理想工

具。它的主要特点是，通过变换，能够充分突出信号某些方面的特征，能对时间（空间）频率进行局部化分析，通过伸缩平移运算对信号（函数）逐步进行多尺度细化，最终达到高频处时间细分。

### **3、离散余弦变换**

![](C:\Users\86151\AppData\Roaming\marktext\images\2024-03-20-10-23-27-image.png)

![](C:\Users\86151\AppData\Roaming\marktext\images\2024-03-20-10-23-33-image.png)

### 4、图像增强和复原

图像增强和复原的目的是为了提高图像的质量，如去除噪声，提高图像的清晰度等。图像增强不考虑图像降质的原因，突出图像中所感兴趣的部分。如强化图像高频分量，可使图像中物体轮廓清晰，细节明显；如强化低频分量可减少图像中噪声影响。图像复原要求对图像降质的原因有一定的了解，一般讲应根据降质过程建立“降质模型”，再采用某种滤波方法，恢复或重建原来的图像。

### 5、图像编码压缩

图像编码压缩技术可减少描述图像的数据量（即比特数），以便节省图像传输、处理时间和减少所占用的存储器容量。压缩可以在不失真的前提下获得，也可以在允许的失真条件下进行。编码是压缩技术中最重要的方法，它在图像处理技术中是发展最早且比较成熟的技术。

### 6、图像变换

由于图像阵列很大，直接在空间域中进行处理，涉及计算量很大。因此，往往采用各种图像变换的方法，如傅立叶变换、沃尔什变换、离散余弦变换等间接处理技术，将空间域的处理转换为变换域处理，不仅可减少计算量，而且可获得更有效的处理（如傅立叶变换可在频域中进行数字滤波处理）。目前新兴研究的小波变换在时域和频域中都具有良好的局部化特性，它在图像处理中也有着广泛而有效的应用。

### 7、图像描述

图像描述是图像识别和理解的必要前提。作为最简单的二值图像可采用其几何特性描述物体的特性，一般图像的描述方法采用二维形状描述，它有边界描述和区域描述两类方法。对于特殊的纹理图像可采用二维纹理特征描述。随着图像处理研究的深入发展，已经开始进行三维物体描述的研究，提出了体积描述、表面描述、广义圆柱体描述等方法。

### 8、图像分类（识别）

图像分类（识别）属于模式识别的范畴，其主要内容是图像经过某些预处理（增强、复原、压缩）后，进行图像分割和特征提取，从而进行判决分类。图像分类常采用经典的模式识别方法，有统计模式分类和句法（结构）模式分类，近年来新发展起来的模糊模式识别和人工神经网络模式分类在图像识别中也越来越受到重视。

### 9、图像分割

图像分割是数字图像处理中的关键技术之一。图像分割是将图像中有意义的特征部分提取出来，其有意义的特征有图像中的边缘、区域等，这是进一步进行图像识别、分析和理解的基础。虽然目前已研究出不少边缘提取、区域分割的方法，但还没有一种普遍适用于各种图像的有效方法。因此，对图像分割的研究还在不断深入之中，是目前图像处理中研究的热点之一。

### 10、峰值信噪比简介

    PSNR (Peak Signal to Noise Ratio) 

峰值信噪比PSNR衡量图像失真或是噪声水平的客观标准。2个图像之间PSNR值越大，则越相似。普遍基准为30dB，30dB以下的图像劣化较为明显。定义为，

![](C:\Users\86151\AppData\Roaming\marktext\images\2024-03-20-10-24-11-image.png)

这里MAX表示图像颜色的最大数值，8bit图像取值为255。我们还要介绍MSE（均方

差），即m×n单色图像 I 和 K（原图像与处理图像）之间均方误差，定义为：

![](C:\Users\86151\AppData\Roaming\marktext\images\2024-03-20-10-24-35-image.png)

## 三、代码实现与解释

---

在本次实验中所有的代码均用MATLAB来实现，具体代码如下所示：

### **1、离散傅里叶变换（DFT）**

```MATLAB
% Clear Memory and Command window
clc;
clear all;
close all;
b=imread("lady.jpg");%读入图像，像素值在b中
b=rgb2gray(b);%转换为灰度图像

figure(1);
I=imbinarize(b);%此处im2bw在matlab2022a之中已经不能使用
imshow(b);
title("(a)原图像");

figure(2);
fa=fft2(I);%使用fft函数进行快速傅里叶变换
ffa=fftshift(fa);%fftshift函数调整fft函数的输出顺序，将零频位置移到频谱的中心
imshow(ffa,[200,225]);%显示灰度在200−255之间的像
title("(b)幅度谱");

figure(3);
l=mesh(abs(ffa));%画网格曲面图
title("(c)幅度谱的能量分布");
```

代码逻辑整体上比较简单，首先使用 clc、clear all 和 close all 指令来清空内存和命令窗口。然后读入一张名为”lady.jpg” 的图像，并将其转换为灰度图像。接着使用 imshow 函数在第一个窗口中显示原图像。在第二个窗口中，使用 fft2 函数进行快速傅里叶变换，并使用 fftshift 函数调整输出顺序，将零频位置移到频谱的中心。最后使用 imshow 函数在第二个窗口中显示幅度谱，其中灰度在 200-225 之间的像素被显示出来。在第三个窗口中，使用 mesh 函数画出幅度谱的能量分布的网格曲面图。

### **2、一级小波分解**

```MATLAB
% Clear Memory and Command window
clc;
clear all;
close all;
b=imread("lady.jpg");%读入图像，像素值在b中
a=im2bw(b);
nbcol=size(a,1);

[ca1,ch1,cv1,cd1]=dwt2(a,'db4');
cod_ca1=wcodemat(ca1,nbcol);
cod_ch1=wcodemat(ch1,nbcol);
cod_cv1=wcodemat(cv1,nbcol);
cod_cd1=wcodemat(cd1,nbcol);

image([cod_ca1,cod_ch1;cod_cv1,cod_cd1]);
```

这段代码是利用`dwt2()`函数进行一级小波分解的。首先使用 clc、clear all 和 close all 指令来清空内存和命令窗口。注意，这是良好的代码习惯。然后读入”lady.jpg” 图像，并将其转换为二值图像。接着使用 size 函数获取二值图像的行数，存储在变量 nbcol 中。然后使用 dwt2 函数进行二维小波变换，使用’db4’作为小波基函数。将小波变换后的系数分别存储在变量 ca1、ch1、cv1 和 cd1中。接着使用 wcodemat 函数将小波系数矩阵进行可视化处理，存储在变量 cod_ca1、cod_ch1、cod_cv1 和 cod_cd1 中。最后使用 image 函数将四个可视化处理后的小波系数矩阵拼接成一个图像，并在 MATLAB 中显示出来。

### **3、二级小波分解**

```MATLAB
% Clear Memory and Command window
clc;
clear all;
close all;
b=imread("lady.jpg");%读入图像，像素值在b中
a=im2bw(b);

nbcol=512;
nbc=256;

[ca1,ch1,cv1,cd1]=dwt2(a,'db4');
[ca2,ch2,cv2,cd2]=dwt2(ca1,'db4');

cod_ca1=wcodemat(ca1,nbc);
cod_ch1=wcodemat(ch1,nbc);
cod_cv1=wcodemat(cv1,nbc);
cod_cd1=wcodemat(cd1,nbc);

cod_ca2=wcodemat(ca2,nbcol);
cod_ch2=wcodemat(ch2,nbcol);
cod_cv2=wcodemat(cv2,nbcol);
cod_cd2=wcodemat(cd2,nbcol);

tt=[cod_ca2,cod_ch2;cod_cv2,cod_cd2];
tt=imresize(tt,size(ca1));

image([tt,cod_ch1;cod_cv1,cod_cd1]);cod_ch1;cod_cv1,cod_cd1]);
```

首先使用 imread 函数读入”lady.jpg” 图像，并将其存储在变量 b 中。接着使用 im2bw 函数将图像转换为二值图像，并将其存储在变量 a 中。然后定义变量 nbcol 和 nbc，分别表示小波系数矩阵的列数。接着使用 dwt2 函数进行二维小波变换，使用’db4’作为小波基函数。将小波变换后的系数分别存储在变量 ca1、ch1、cv1 和 cd1 中。然后再次使用 dwt2 函数对 ca1 进行小波变换，将小波变换后的系数分别存储在变量 ca2、ch2、cv2 和 cd2 中。接着使用 wcodemat 函数将小波系数矩阵进行可视化处理，存储在变量 cod_ca1、cod_ch1、cod_cv1 和 cod_cd1 中。然后使用 wcodemat 函数将小波系数矩阵进行可视化处理，存储在变量 cod_ca2、cod_ch2、cod_cv2和 cod_cd2 中。接着将 cod_ca2、cod_ch2、cod_cv2 和 cod_cd2 拼接成一个图像，存储在变量 tt 中。然后使用 imresize 函数将 tt 的大小调整为 ca1 的大小。最后使用 image 函数将四个可视化处理后的小波系数矩阵拼接成一个图像，并在 MATLAB 中显示出来

### **4、离散余弦变换**

```MATLAB
% Clear Memory and Command window
clc;
clear all;
close all;
b=imread("lady.jpg");%读入图像，像素值在b中
b=rgb2gray(b);%转换为灰度图像

figure(1);
imshow(b);
title('(a)原图像');

I=im2bw(b);
figure(2);
c=dct2(I);%进行离散余弦变换
imshow(c);
title('(b)DCT变换系数');

figure(3);
mesh(c);%画网格曲面图
title('(c)DCT变换系数（立体视图）');(c)DCT变换系数（立体视图）');
```

在读入图片后，将其存储在变量 b 中。然后使用 rgb2gray 函数将图像转换为灰度图像。接着使用 imshow 函数在第一个窗口中显示原图像。在第二个窗口中，使用 im2bw 函数将灰度图像转换为二值图像，并使用 dct2 函数进行离散余弦变换，将变换后的系数存储在变量 c 中。然后使用 imshow 函数在第二个窗口中显示变换后的系数。在第三个窗口中，使用 mesh 函数画出变换后的系数的网格曲面图，并使用 title 函数为图像添加标题。最后在 MATLAB 中显示出来。

## 三、实验结果

---

### **1、傅里叶变换**

下图为lady的二值图像

![](D:\dasanxia\xinxiyincangjishu\2111033\2\1.png)

下图为对其做傅里叶变换得到幅度谱

![](D:\dasanxia\xinxiyincangjishu\2111033\2\2.png)

下图为立体分布

![](D:\dasanxia\xinxiyincangjishu\2111033\2\3.png)

### **2、一级小波分解**

对lena的灰度图像进行小波分解，再伪彩色处理，共分为如下四部分：

1. 近似部分
2. 水平方向细节部分
3. 垂直方向细节部分
4. 对角线方向细节部分

最终如下图所示：

![](D:\dasanxia\xinxiyincangjishu\2111033\2\dwt1.png)

### **3、二级小波分解**

对一级小波分解的近似部分再进行小波分解，可得到二级小波分解，最终结果如下图所示：

![](D:\dasanxia\xinxiyincangjishu\2111033\2\dwt2.png)

### **4、离散余弦变换**

下图为lady的二值图像

![](D:\dasanxia\xinxiyincangjishu\2111033\2\dct1.png)

下图为对其做离散余弦变换得到幅度谱

![](D:\dasanxia\xinxiyincangjishu\2111033\2\dct2.png)

下图为立体分布

![](C:\Users\86151\AppData\Roaming\marktext\images\2024-03-25-15-59-14-image.png)

## 四、参考文献

- PentatonicScale,图像处理PSNR及其计算（OpenCV和matlab实现）,http://blog.csdn.net/laoxuan2011/article/details/51519062.

## 五、总结与展望

---

在本次实验中，首先学习了一些普遍的常用图像处理方法以及一些公式，比如二维离散傅立叶变换、二维离散小波变换等，然后通过在`MATLAB`中复现用快速傅立叶变换、一级小波分解、二级小波分解、离散余弦变换来对图像信号进行处理，对所学到的理论知识进行相应的应用，对`MATLAB`的应用也更加的熟练，最后期待自己未来更好的发展，在学习信息隐藏技术这门课程的过程当中学习到更丰富的知识。
