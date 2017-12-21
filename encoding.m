function [ encoded,enc_type,count,n_bits ] = encoding( L,T,mp,max_level,quantized,delta,len )
%len = number of samples 
enc_type=input('Please choose the type of encoding 1 or 2 or 3\n (1)Unipolar NRZ \n (2)Polar NRZ \n (3)Manchester\n Your choice:  ');

count=0; 
n_bits=log2(L); %number of bit representation
binary_arr=zeros(len,n_bits); % will hold the binary rep of the quantized signal 
for j=1:len
    count=0;
    for i=-max_level:delta:max_level
        if(quantized(j)==i)
            encoding_array(j)=count;  %  map each quantized output to its level number 
            col=n_bits;
            %change to binary 
            while (count>0)
                binary_arr(j,col)=mod(count,2);
                count=floor(count/2);
                col=col-1;
            end
            break;
        end
        count=count+1;
    end
end

bin=binary_arr';
encoded=bin(:); %  array to vector 
encoded=mp.*encoded;

if(enc_type~=3)%not manchester
    if(enc_type==2)% if polar
        encoded(encoded==0)=-mp;  
    end
    T2=T/n_bits; % we did this in order to plot 3 bits (representing a sample) in one TS
    n2=0:size(encoded)-1;   %check
    
    figure(3);
    stem(n2*T2,encoded,'LineStyle','-.');
    hold on
    stairs(n2*T2,encoded,'red');
    set(gca,'ylim',[-1.2*mp 1.2*mp])
    xlim([0 (n_bits*len-1)*T2])
encoded=encoded';  % to simplify the output for further computation  (to eualize the size whether its manchester or not)
 
else %if manchester
    
    man_array=zeros(1,size(encoded,2)*2);
    %transform the original encoded array to be a manchester one
    j=1;
    for i=1:size(encoded,1)
        if(encoded(i)==0)
            man_array(j)=-1;
            man_array(j+1)=1;
        else
            man_array(j)=1;
            man_array(j+1)=-1;
        end
        j=j+2;
    end
    man_array;
    man_array=mp.*man_array;
    
    n3=0:size(man_array,2)-1;
    T3=T/2*n_bits;
    
    figure(3);
    title('Encoder Output' );
    stem(n3*T3,man_array,'LineStyle','-.');
    hold on
    stairs(n3*T3,man_array,'red');
    set(gca,'ylim',[-1.2*mp 1.2*mp])
    xlim([0 (size(man_array,2)-1)*T3])
    
    encoded=man_array;
end
hold off

end

