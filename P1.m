P1.a
fs=44100;
f0=689;
f1=10002;
f2=1716;
f3=2589;
f4=12088;
k=1:2^16;
N=2^16;
x0=cos(2*pi*f0*k/fs);
x1=cos(2*pi*f1*k/fs);
x2=cos(2*pi*f2*k/fs);
x3=cos(2*pi*f3*k/fs);
x4=cos(2*pi*f4*k/fs);
plot(fs*k/N,abs(fft(x0,N)))
hold on
plot(fs*k/N,abs(fft(x1,N)))
hold on
plot(fs*k/N,abs(fft(x2,N)))
hold on
plot(fs*k/N,abs(fft(x3,N)))
hold on
plot(fs*k/N,abs(fft(x4,N)))
axis([0,22050,0,40000])
grid
xlabel('Frequency')
ylabel('Magnitude')

P1.b:
fs=44100;
f0=689;
f1=10002;
f2=1716;
f3=2589;
f4=12088;
k=1:2^16;
N=2^16;
x0=cos(2*pi*f0*k/fs);
x1=cos(2*pi*f1*k/fs);
x2=cos(2*pi*f2*k/fs);
x3=cos(2*pi*f3*k/fs);
x4=cos(2*pi*f4*k/fs);
x=x0+0.5*x1+0.333*x2+0.25*x3+0.2*x4;
y=downsample(x,4);
ky=1:(2^16)/4;
subplot(2,1,1)
plot(fs*k/N,abs(fft(x,N)))
axis([0,22050,0,20000])
grid
xlabel('Frequency(Hz)')
ylabel('Magnitude')
title('Sample of x')
subplot(2,1,2)
plot(fs*ky/N,abs(fft(y)))
axis([0,5520,0,2000])
grid
xlabel('Frequency(Hz)')
ylabel('Magnitude')
title('Sample of y')

P1.c:
t=0:1/44100:1;
fs=44100;
k=1:length(t);
x=chirp(t,0,1,8000);
y=downsample(x,4);
%plot(y);
%axis([0,20000,0,1])
[num,den]=cheby2(5,40,(fs/16)/(fs/2));
z=filter(num,den,x);
w=downsample(z,4);
t_=0:4/44100:1;
k_=1:length(t_);
subplot(2,2,1)
plot(k,abs(fft(x)))
axis([0,fs/2,0,500])
xlabel('Frequency(Hz)')
ylabel('Magnitude')
title('x')
subplot(2,2,2)
plot(k_,abs(fft(y)))
axis([0,fs/8,0,200])
xlabel('Frequency(Hz)')
ylabel('Magnitude')
title('y')
subplot(2,2,3)
plot(k,abs(fft(z)))
axis([0,fs/2,0,400])
xlabel('Frequency(Hz)')
ylabel('Magnitude')
title('z')
subplot(2,2,4)
plot(k_,abs(fft(w)))
axis([0,fs/8,0,100])
xlabel('Frequency(Hz)')
ylabel('Magnitude')
title('w')


