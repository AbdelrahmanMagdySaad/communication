function [ ] = reconstruction_filter( decoded,fs,signal,t,x1,fm)

%convolution with sinc 0> in frequencty multiplying with rect
j=1;
for i=t
    temp= 0;
    for n=1:size(decoded,2)
        temp=temp+decoded(n)*sinc((i-n*(1/fs))/(1/fs));
    end
    Reconstructed(j) =temp;
    j=j+1;
end
figure
title('Reconstructed signal with the original signal')
plot(t,signal);
hold on
plot(t,Reconstructed,'red');
hold off
figure
title('Frequency representation')

k=-200:1:199;
y=abs(fftshift(fft(signal)));


subplot(3,1,1);
plot(k,y)
subplot(3,1,2);
k=-200:1:199;
y=abs(fftshift(fft(Reconstructed)));
plot(k,y)

subplot(3,1,3);

k=-fs/2:fm/2:fs/2;
y=abs(fftshift(fft(x1)));

plot(k,y)


end

