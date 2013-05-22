#! /bin/octave
# Synthesis part of the Vocoder on a WAVE file

function x = synthesis2(X0,R,hinterpol,number_of_samples)
# X : DFT a fenetre obtenue precedemment
# R : parametre d'echantillonnage

if nargin < 2 ;
	R = 1 ;
end ;

if nargin < 3 ;
	hinterpol = sinc(pi*((-2*R):(2*R))/R) ;
end ;

if size(hinterpol,2) == 1 
	hinterpol = hinterpol' ;
end ;

if nargin < 4 ;
	number_of_samples = size(X0,1) ;
end ;

# Le filtre a pour taille totale : 2*Q*R +1 
Q = (size(hinterpol,2) -1) /(2*R) ;

N = size(X0,2) ;	
inputsize = size(X0,1) ;




# filtre d'interpolation, facilite les calculs après
#for n = 1:R ;
#	temp = hinterpol(n:R:(2*R*Q+1)) ;
#	f(:,n)= [temp , zeros(1,2*Q+1-size(temp,2)) ] ;
#end ;


#Interpolation lineaire 
f = [ ((R-1):(-1):0) /R ; (0:(R-1)) /R ] ;

# On étend X0 pour éviter les dépassements de tableau
X0 = [X0(:,:) ; zeros(1,N)] ;
x = [] ;
# on calucul les résultats par blocs de R à la fois
for n = 1:inputsize ;
	s = ifft(X0(n:(n+1),:),[],2) ;
	s = shift(s,mod(-n*R,N),2) ;
	s = s(:,1:R) ;
	x = [x , real(sum(f .* s,1)) ] ;
end ;	
x = x(1:(R*number_of_samples)) ;


endfunction