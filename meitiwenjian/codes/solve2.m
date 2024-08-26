fid = fopen('secrets.wav', 'r');
oa = fread(fid, inf, 'uint8');
m = oa;
n= length(oa) - 156;
for i = 1 : n
    w(i) = bitget(m(156 + i), 1);
end
fclose(fid);
rate = length(find(w ~= d)) / length(d);
disp(rate);