clear;

fid=fopen('belong.wav','r');
oa=fread(fid,inf,'uint8');
fclose(fid);
n=length(oa)-156;
d=randsrc(1,n,[1 0]);
M=oa;
for i = 157 : 157 + n - 1
    M(i) = bitset(M(i), 1, d(i - 156));
end
fid = fopen('secret.wav', 'wb');
fwrite(fid, M, 'uint8'); 
fclose(fid);
figure;
[y1,Fs] = audioread('belong.wav');
x1 = (0:length(y1) - 1)/Fs;
subplot(2, 1, 1);
plot(x1, y1);
axis([0 max(x1) -1 1]);
xlabel('Time / (s)');ylabel('Amplitude');title('original audio');
[y2,Fs] = audioread('secret.wav');
x2 = (0:length(y2)-1)/Fs;
subplot(2, 1, 2);
plot(x2, y2); 
axis([0 max(x2) -1 1]);
xlabel('Time / (s)');ylabel('Amplitude');title('information hiding audio');
figure;
subplot(2, 1, 1); plot(x1, y1); axis([0 0.6 -0.05 0.05]);
xlabel('Time / (s)');ylabel('Amplitude');title('original audio');
subplot(2, 1, 2); plot(x2, y2); axis([0 0.6 -0.05 0.05]);
xlabel('Time / (s)');ylabel('Amplitude');title('information hiding audio');

