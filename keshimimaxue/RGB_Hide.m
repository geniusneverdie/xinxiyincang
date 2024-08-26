A=imread('A.png');
B=imread('B.png');
C=imread('C.png');


A1=zeros(256,'uint8'); A2=zeros(256,'uint8'); A3=zeros(256,'uint8');
B1=zeros(256,'uint8'); B2=zeros(256,'uint8'); B3=zeros(256,'uint8');
C1=zeros(256,'uint8'); C2=zeros(256,'uint8'); C3=zeros(256,'uint8');
for i = 1:256
    for j = 1:256
        for k = 1:3
            if k==1
                A1(i,j)=A(i,j,k);
                B1(i,j)=B(i,j,k);
                C1(i,j)=C(i,j,k);
            end
            if k==2
                A2(i,j)=A(i,j,k);
                B2(i,j)=B(i,j,k);
                C2(i,j)=C(i,j,k);
            end
            if k==3
                A3(i,j)=A(i,j,k);
                B3(i,j)=B(i,j,k);
                C3(i,j)=C(i,j,k);
            end
        end
    end
end
[A1] = Halftone(A1);[A2] = Halftone(A2);[A3] = Halftone(A3);
[B1] = Halftone(B1);[B2] = Halftone(B2);[B3] = Halftone(B3);
[C1] = Halftone(C1);[C2] = Halftone(C2);[C3] = Halftone(C3);

X=zeros(512,'uint8'); Y=zeros(512,'uint8'); Z=zeros(512,'uint8');

X1=zeros(512,'uint8'); Y1=zeros(512,'uint8'); Z1=zeros(512,'uint8');
X2=zeros(512,'uint8'); Y2=zeros(512,'uint8'); Z2=zeros(512,'uint8');
X3=zeros(512,'uint8'); Y3=zeros(512,'uint8'); Z3=zeros(512,'uint8');

[Y1,Z1]= Binary_Hide(A1,B1,C1);
[Y2,Z2]= Binary_Hide(A2,B2,C2);
[Y3,Z3]= Binary_Hide(A3,B3,C3);


X1 = And(Y1,Z1);
X2 = And(Y2,Z2);
X3 = And(Y3,Z3);


% 三个维度重新恢复为RGB图像

for i = 1:512
    for j = 1:512
        for k = 1:3
            if(k==1)
            X(i,j,k)=X1(i,j);
            Y(i,j,k)=Y1(i,j);
            Z(i,j,k)=Z1(i,j);
            end
            if(k==2)
            X(i,j,k)=X2(i,j);
            Y(i,j,k)=Y2(i,j);
            Z(i,j,k)=Z2(i,j);
            end
            if(k==3)
            X(i,j,k)=X3(i,j);
            Y(i,j,k)=Y3(i,j);
            Z(i,j,k)=Z3(i,j);
            end
        end
    end
end

subplot(1,3,1);
imshow(X);
subplot(1,3,2);
imshow(Y);
subplot(1,3,3);
imshow(Z);