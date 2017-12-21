function [fm,x1,n,t,T,mp,signal,fs,nmin,nmax ] = sampling( )
%for choice 1 you can enter any fuction but with the same frequency for example 5*cos(2*pi*fm*t) or
%5*cos(2*pi*fm*t)+3*sin(2*pi*fm*t)
%for choice 2 you can enter any fuctions with two different frequencies
c=input('pls choose input one function (1)or sum of two functions(2) :');
if c==1
fm=input('enter frequency of input signal(fm) : ');
else if c==2 %incase two different frequencies
fm1=input('enter frequency of input signal1(fm1) : ');        
fm2=input('enter frequency of input signal2(fm2) : ');
   fm=max(fm1,fm2);
    end
end   
fs= input('enter fs : ');
tmin = 0 ;  %-1/fm;
tmax = 2/fm; %1/fm;  %range of ploting
t = linspace(tmin, tmax, 400);
T = 1/fs;      %Ts sampling time
nmin = ceil(tmin / T);  % get number of samples in the graph 
nmax = floor(tmax / T);
n = nmin:nmax;
signal=input('signal ex:5*cos(2*pi*fm*t),input fm & t as symbols  :');
x1=input('please enter signal same as the above change t-> n*T input fm,n,T as symbols :');
mp=max(signal);
plot(t,signal)
xlabel('t (seconds)')

figure(1);
title('input sampled signal')
hold on;
plot(t,signal,'-.b');
stem(n*T,x1,'red');

hold off


end

