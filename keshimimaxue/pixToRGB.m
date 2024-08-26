function [vec] = pixToRGB(PIX,w,h)
    vec = zeros(w,h);
    for i = 1:w
        for j = 1:h
            vec(i,j) = bi2de(squeeze(PIX(i,j,:))',2,'left-msb');
        end;
    end;
return;