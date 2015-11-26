%number of the symbors

nsym = 2^6;

%create real portion of QPSK symbol

realqpsk = (-1).^(rand(nsym)>0.5);

%create imag portion of QPSK symbol

imagqpsk = (-1).^(rand(nsym)>0.5).*i;

%Combine imag and real portions of QPSK symbol

qpsk = 0.707*[realqpsk+imagqpsk];

figure(1);

plot(qpsk,'o');%plot constellation without noise

axis([-2 2 -2 2]);

grid on;

xlabel('In-Phase'); ylabel('Quadrate');

title('QPSK constellation');

%define signals added with noise and signals received by the OFDM receive module

qpsk_noise=zeros(1,length(qpsk));

receiver=zeros(1,length(qpsk));

%signal to noise ratio in dB, construct the noise and add to the signal

snr_db = 5;

snr = 10^(snr_db/10);

ser = 0;

for k=1:64

    %64-sample IFFT    

    sig = ifft(qpsk(k,1:end));

    for x=1:64

        %AWGN(additive white Gaussian noise)

        qpsk_noise(x) = real(sig(x))+1/snr*randn()+1i*(imag(sig(x))+1/snr*randn());  
    end
    receiver(k,1:64) = fft(qpsk_noise);
end    

% construct boolean check for error

real_receiver = sign(real(receiver));

imag_receiver = sign(imag(receiver));

real_check = realqpsk+real_receiver;

imag_check = imag(imagqpsk)+imag_receiver;

% Count the number of sign changes to get the Symbol Error Rate

for y=1:4096

    if((real_check(y) ==0) || (imag_check(y) ==0))

        ser = ser +1;

    end

end

figure(2);

plot(receiver,'o'); % plot constellation with noise

axis([-2 2 -2 2]);

grid on;

xlabel('In-Phase'); ylabel('Quadrate');

title('QPSK constellation with noise');

%print the symbol error rate directly to terminal

sprintf('Symbol Error Rate is：%d',ser/4096)
