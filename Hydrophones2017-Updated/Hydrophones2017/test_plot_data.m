%An example for plotting the fft of some data
Fs = 1e5;         %sampling frequency
N = 512;          %data and fft length
f = (0:N-1)*Fs/N; %frequency x-axis

[data0,data1,data2,data3] = parse_hydrophones('last.log',512,1);
plot(f,abs(fft(data3))) %plot the fft