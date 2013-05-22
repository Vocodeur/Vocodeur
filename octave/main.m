#! /bin/octave
# Synthesis part of the Vocoder on a WAVE file


# Retrieve samples and choose its size
[samples,FS,BPS] = wavread(argv(){1}) ;
samples = samples(1:50000) ;
# if multiple channels, keep only one

#Display samples
	figure (1)
	plot(samples(1:10:50000));
	title("Samples");

if size(samples,2) > 1 ;
	samples = samples(:,1) ;
end ;

# treat samples as a line vector
samples = samples' ;

N = 2^8 ;
R = N/4 ;
M = 3*N ;
Q = 2*R ;
h = sinc(pi*(-M:M)/N) ;
hinterpol = sinc(pi*((-Q):(Q))/R) ;
buffsize = 50000 ;


# Display the window
figure(2);
plot((-M:M), h);
title("Window");

Xres = [] ;

for i = 1:buffsize:size(samples,2) ;
	printf("**********bloc %d/%d************\n",i/buffsize+1,size(samples,2)/buffsize) ;
	buff = samples(i:min(i+buffsize+2*M+1,size(samples,2))) ;

	Xres = [Xres; analysis(buff,N,R,h,buffsize)] ;


end ;	
	
# Display the ith analysis sequence
i = 100 ;
figure(3);
plot(abs(Xres(i,:)));
title("Analysis sequence number 100");

x = [] ;
for i = 1:buffsize:size(samples,2) ;
	printf("******synthesis : bloc %d/%d********\n",i/buffsize+1,size(samples,2)/buffsize) ;
	buff = Xres(i:min(i+buffsize+2*Q+1,size(Xres,1)),1:N) ;
	x = [x , synthesis2(Xres,R)] ;
end ;

filtre = sinc(100*pi*(-2*N:2*N)/N) ;

x = conv(x,filtre) ;
figure(4) ;
plot(x) ;
title("x after Analysis and Synthesis") ;

pause() ;
wavwrite(x',FS,BPS,"../wavefiles/test.wav") ;