
s = argv(){1} ;
samples = wavread(s) ;
samples = samples(:) ;
N = 2^10 ;
M = 3*N ;
h = sinc((-M:M)/N)' ;
freq = fft(samples(1:(2*M+1)) .* h) ;
plot(abs(fftshift(freq))) ;
title(s) ;
print("../image.png") ;
pause() ;
