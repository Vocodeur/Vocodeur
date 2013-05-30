rate = 2. ;
N = 2^8 ;
M = N ;
R = 4 ;


[samples,A,B] = wavread(argv(){1}) ;

samples = samples(:) ;
samples = samples(1:100000) ;
[X,C] = stft(samples) ;


samples = interp1(samples,1:rate:length(samples)) ;

X = fftshift(X) ;
plot(abs(X(:,100))) ;

N = size(X,1) ;
% Xabs = 1:size(X,1) ;
% Xord = 1:size(X,2) ;

% Yabs = 1:rate:(rate*size(X,1)) ;
% disp(size(Xabs)) ;
% disp(size(Xord)) ;
% disp(size(X)) ;

% X = interp2(Xabs',Xord,X,Yabs,Xord,'linear',0) ;

for i = 1:size(X,2) ;
X((N/2+1):N,i) = interp1((N/2+1):N,X((N/2+1):N,i),N/2+(1:rate:(N/2*rate)),0) ;
% X((N/2):(-1):1,i) = interp1((N/2):(-1):1,X((N/2+1):N,i),N/2-(0:rate:((N/2-1)*rate)),0) ;
X(1:N/2,i) = X(N:(-1):(N/2+1),i) ;
printf("%d/%d\n",i,size(X,2)) ;
end ;


figure(2) ;
plot(abs(X(:,100))) ;

X= fftshift(X) ;
x = real(synthesis(X,C)) ;
pause() ;
wavwrite(x,A,B,"../wavefiles/test.wav") ;
