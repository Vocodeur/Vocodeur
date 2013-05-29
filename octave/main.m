#! /bin/octave
# Synthesis part of the Vocoder on a WAVE file

rate = 2. ;


# Retrieve samples and choose its size
[samples,FS,BPS] = wavread(argv(){1}) ;
# if multiple channels, keep only one

#Display samples
	figure (1)
	plot(samples(1:10:length(samples)));
	title("Samples");

if size(samples,2) > 1 ;
	samples = samples(:,1) ;
end ;

# samples : line vector
samples = samples' ;

samples = interp1(samples, 1:rate:size(samples,2)) ;
% samples = samples(1:100000) ;


N = 2^6 ;
R = N/64 ;
M = 3*N ;
h = sinc(pi*(-M:M)/N) ;
number_of_blocs = 8 ;
buffsize = N*ceil(length(samples) / number_of_blocs / N) ;
printf("taille du buffer : %d\n",buffsize) ;
% buffsize = length(samples) ;

# Display the window
figure(2);
plot((-M:M), h);
title("Window");

% Xres = zeros(length(samples)/R,N) ;
Xres = [] ;
for i = 1:buffsize:size(samples,2) ;
	printf("**********bloc %d/%d************\n",i/buffsize+1,size(samples,2)/buffsize+1) ;
	buff = samples(i:min(i+buffsize+2*M+1,size(samples,2))) ;
	% Xres(buffsize/R*(i-1) + (1:min(size(buff,2),buffsize)/R),:) = analysis(buff,N,R,h,min(size(buff,2),buffsize)) ;
	Xres = [Xres ;  analysis(buff,N,R,h,min(size(buff,2),buffsize)) ] ; 
end ;	
printf("End Analysis\n") ;


Xres = fftshift(Xres,2) ;
	
# Display the ith analysis sequence
i = 100 ;
figure(3);
plot(abs(Xres(i,:)));
title("Analysis sequence number 100");

# matrice pour modifier le spectre
mat = zeros(N) ;

for i = 1:(N/2) ;
	j = floor(i*rate)  ;
	f = i*rate - j ;
	if j <= N/2 ;
		mat(N/2+j,N/2+i) = (1-f) ; 
	end ;
	if j+1 <= N/2 ;
		mat(N/2+j+1,N/2+i) = f ;
	end ;
end ;

for i = 1:(N/2) ;
	j = floor(i*rate) ;
	f = i*rate - j ;
	if j <= N/2 ;
		mat(N/2-j+1,N/2-i+1) = (1-f) ; 
	end ;
	if j+1 < N/2 ;
		mat(N/2-j-1,N/2-i+1) = f ;
	end ;
end ;

Xres = Xres * mat ;


# Display the ith analysis sequence
i = 100 ;
figure(3);
plot(abs(Xres(i,:)));
title("Analysis sequence number 100");

Xres = fftshift(Xres,2) ;

x = zeros(1,size(Xres,1)*R) ; 
for i = 1:buffsize:size(samples,2) ;
	printf("******synthesis : bloc %d/%d********\n",i/buffsize+1,size(samples,2)/buffsize+1) ;
	buff = Xres(i:min(i+buffsize+1,size(Xres,1)),1:N) ;
	res = synthesis2(buff,R,min(buffsize,size(buff,1))) ;
	x(i:(i+size(res,2)-1)) = res ;
end ;
printf("End Synthesis\n") ;

x = x /norm(x) * norm(samples) ;

figure(4) ;
plot(x) ;
title("x after Analysis and Synthesis") ;

pause() ;
wavwrite(x',FS,BPS,"../wavefiles/test.wav") ;