#! /bin/octave
# Analysis part of the Vocoder on a WAVE file

function X = analysis(samples,N,R,h,number_of_samples)
	# renvoie le résultat de la DFT a fenetre de samples
	# N : nombre de canaux de fréquence à considérer ;
	# R : taux d'échantillonnage
	# h : fonction de fenêtrage
	# number_of_samples : nombre de valeurs attendue en sortie
	# si samples a une taille plus grande, les valeurs en plus seront utilisées 
	# au lieu de compléter par des zéros
	
printf("Analysis begin\n") ;

	
if (nargin < 2) || (length(N) == 0) ;
	# default value for N
	N = 2^7 ;
end ;

if (nargin < 3) || (length(R) == 0) ;
	# default value for R
	R = N/4 ;
end ;



# Window if not given in argument
if nargin < 4 ;
	# Semi-duration of the window
	M = 3*N;	
	# Window
	h = sinc(pi*(-M:M)/N) ;
else 
	M = (size(h,2)-1)/2 ;
end ;

if size(samples,2) == 1 ;
	# samples horizontal
	samples = samples' ;
end ;


if nargin < 5 ;
	number_of_samples = size(samples,2) ;
end ;

size_samples = size(samples,2) ;

if size(h,2) == 1 ;
	h = h' ;
end ;


# Compute sequences for analysis
# Precalculus of hi, used in the loop after
# Precalculus of a part of the shift made to x in the main loop
for m = 1:N ;
		hi(m,:) = [h, zeros(1,N)]((-M:N:M) +M +1 +m) ;
		xshift(m,:) = [samples(m:size_samples) , zeros(1,m-1+2*M+1)] ;
	end ;
	
# xt : values before the fft.	
xt = zeros(number_of_samples/R,N) ;

for i = (1:R:number_of_samples) ;
	xt((i-1)/R +1,:) = sum(xshift(:, i + M+1 +(-M:N:M)) .* hi,2) ;
	xt((i-1)/R +1,:) = shift(xt((i-1)/R +1,:),mod(i,N)) ; 
	printf("%d/%d analysis sequences computed\n", i/R, number_of_samples/R);
	end ;
	
# X obtained at the end is the correct one (shift made line 42)
X = fft(xt,[],2);

printf("Analysis finished.\n");
endfunction ;