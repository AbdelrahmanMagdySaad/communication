function [ quantized,L,delta,max_level,len,mho ] = quantizing(  x1,n,T,mp  )

qtype=input('pls enter 1 for uniform quantizedizer ,2 for non uniform : ');
L=input('pls enter the number of levels : ');
   %mp wa5dha mn el sampling
delta=2*mp/L; 
max_level=(L-1)*delta/2;
error=delta/2;  % calculating error for simplicity in the code below
  
len=length(x1);
double quantized(len);
if qtype==1

    
  %for uniform quantizer map each value to a quantized level 
for j=1:len
  for i=-max_level:delta:max_level
    if(abs(x1(j)-i)<=error)
      quantized(j)=i;
      break;
    end
  end 
end


end

mho=0;
%for non-uniform quantizer first compress the signal then map each value to a quantized level 
if qtype==2
     mho=input('pls enter mho value : ');
     non_uni=log(1+abs(mho * x1 / mp))/log(1+mho).*sign(x1);
for j=1:len
  for i=-max_level:delta:max_level
    if(abs(non_uni(j)-i)<=error)
      quantized(j)=i;
      break;
    end
  end 
end
end

figure(2);
title('Quantized Output with sampled signal')
stem(n*T,x1,'filled','markersize',7);           
hold on
stairs(n*T,quantized,'red');
ylim([-mp mp]);
hold off
end

