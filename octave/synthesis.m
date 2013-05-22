#! /bin/octave
# Synthesis part of the Vocoder on a WAVE file

function x = synthesis(X0,R)
# X : DFT a fenetre obtenue precedemment
# R : parametre d'echantillonnage

N = size(X0,2) ;	
number_of_samples = R * size(X0,1) ;

for m = 1:N ;
X(:,m) = interp1(1:R:number_of_samples,X0(:,m),(1:number_of_samples)) ;
end ;

for i = 1:(size(X,1)) ;
x(i) = real(ifft(X(i,:))(mod(i-1,N)+1)) ;	
end ;

endfunction ;

