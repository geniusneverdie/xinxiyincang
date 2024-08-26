    im1 = imread('share1.png');
    k=6;
    [im_width, im_height, channels] = size(im1);
    share = zeros(k,im_width,im_height,3);
    final = zeros(im_width, im_height, 3);
    for i = 1:k
    X = uigetfile('*.jpg;*.bmp;*.tiff;*.ppm;*.pgm;*.png','pick a jpg  file');
    im = imread(X);
    for j = 1:im_width
    for l = 1:im_height
    share(i,j,l,1) = im(j,l,1);
    share(i,j,l,2) = im(j,l,2);
    share(i,j,l,3) = im(j,l,3);
    end;
    end;
    end;
    for i = 1:k
    for j = 1:im_width
    for l = 1:im_height
    final(j,l,1) = bitor(final(j,l,1),share(i,j,l,1));
    final(j,l,2) = bitor(final(j,l,2),share(i,j,l,2));
    final(j,l,3) = bitor(final(j,l,3),share(i,j,l,3));
    end;
    end;
    end;
    19
    final = uint8(final);
    imwrite(final, 'output.png', 'png');
    output_image = imageProcess(imread('output.png'));%调用加密时的函数
    imwrite(output_image,'decryptedoutput.png','png');
    figure
    subplot(1,2,1),imshow('output.png');
    subplot(1,2,2),imshow('decryptedoutput.png');
    axes_handle = get(gcf, 'children');
    axes(axes_handle(2)); title('K=1/2/3/4/5/6');
    axes(axes_handle(1)); title('AES 解密');