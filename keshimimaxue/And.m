function[X] = And(Y,Z)
for i = 1:256*2
    for j = 1:256*2
        if(Y(i,j)==255&&Z(i,j)==255)
            X(i,j)=255;
        else
            X(i,j)=0;
        end
    end
end
