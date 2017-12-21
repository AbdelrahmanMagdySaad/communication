% 
% Created on Wed Dec  21  2017
% 
% @authors: Abdelrahman Magdy and Ahmed Alkhair

clc;
clear all;
close all;


[fm,x1,n,t,T,mp,signal,fs,nmin,nmax ] = sampling( );
%----------------------quantization-------------------------------
[ quantized,L,delta,max_level,len,mho ] = quantizing( x1,n,T,mp  );

%--------------------------------------------------------------------------
%-------------------------encoding-----------------------------------------
[ encoded,enc_type,count,n_bits ] = encoding( L,T,mp,max_level,quantized,delta ,len);

%---------------------------------------------------------------
%----------------------decoding---------------------------------

[ decoded ] = decoding( encoded,mp,enc_type,max_level,delta,mho,count,n_bits );
%---------------------------------------------------------------------
%------------------reconstruction filter------------------------------
reconstruction_filter( decoded,fs,signal,t,x1,fm);






