#! /bin/octave
# Synthesis part of the Vocoder on a WAVE file


# Retrieve samples and choose its size
[samples,FS,BPS] = wavread(argv(){1}) ;
samples = samples(3501:53500) ;


N = 2^8 ;
R = N/4 ;
M = 3*N ;
h = sinc(pi*(-M:M)/N) ;

# Display samples
figure (1)
plot(samples);
title("Samples");


# Display the window
figure(2);
plot((-M:M), h);
title("Window");

run analysis.m
Xres = analysis(samples,N,R,h) ;


# Display the ith analysis sequence
i = 100 ;
figure(3);
plot(abs(Xres(i,:)));
title("Analysis sequence number 100");


x = synthesis(Xres,R) ;
figure(4) ;
plot(x) ;
title("x after Analysis and Synthesis") ;

pause() ;
wavwrite(x',FS,BPS,"../wavefiles/test.wav") ;