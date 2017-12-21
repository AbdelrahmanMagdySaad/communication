function [ decoded ] = decoding( encoded,mp,enc_type,max_level,delta,mho,count,n_bits )
% i have n_bits , encoded array , type 
% first convert to decimal 
% then map this numbers to the quantized level 


decoded=zeros(1,size(encoded,2)/(n_bits*(1+floor(enc_type/3))));
encoded=1/mp .*encoded;

j=1;

if(enc_type==3)% transform manchester to uni polar to facilitate computation
    for i=1:2:size(encoded,2)
        if encoded(i)==1
            temp(j)=1;
        else
            temp(j)=0;
        end
    j=j+1;    
    end
    encoded=temp;
end

    
    
j=1;%indexing decoding array
if(enc_type==2)  %transform polar to uni polar to facilitate computation
    encoded(encoded<0)=0;
end

%now any encoding array transformed into unipolar 
for i=1:n_bits:size(encoded,2)
    for k=1:n_bits
         decoded(j)=decoded(j)+2^(n_bits-k)*encoded(i+k-1);
    end
     j=j+1;
end


%transform level number to the quantized value 
for i=-max_level:delta:max_level
    decoded(decoded==count)=i;
    count=count+1;
end

if(mho>0) %expand the non uniform quantized signal
    temp=(((1+mho).^abs(decoded))-1)/mho.*sign(decoded);
    decoded=mp.*temp;
end

end

