    x=imread('lena.bmp')
    ImgInp=imresize(x, [256, 256]);
    [height,width]=size(ImgInp);
    n=height*width;
    user_key='abcd';
    user_key = double(user_key);
    key = zeros(n,1,'uint8');
    for ind = 1 : n
    ind_user_key = mod(ind,size(user_key,2)) + 1;
    key(ind) = mod(bitxor(mod((mod(bitxor((ind.^2),user_key(ind_user_key)),256)).^2,256),ind),256);
    end;
    [n m p] = size(ImgInp);
    ind = 1;
    for i = 1:n
    for j = 1:m
    for k = 1:p
    ImgInp(i,j,k) = bitxor(ImgInp(i,j,k),key(ind));
    end;
    ind = ind + 1;
    end;
    end;
    imwrite(ImgInp,'ImgInp.png','png')
    figure;
    imshow(ImgInp);
    return;