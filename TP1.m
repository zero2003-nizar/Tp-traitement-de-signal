clear all
close all
clc

fe = 1e4;
te = 1/fe;
N = 5000; 
t = (0:N-1)*te; 

%% Représentation temporelle et fréquentielle 
x = 1.2*cos(2*pi*440*t+1.2)+3*cos(2*pi*550*t)+0.6*cos(2*pi*2500*t);
figure;

% 1)-:


subplot(2,3,1)
plot(t,x,'.');
title('Le signal x(t)')


%2)-:
% création du vecteur f qui correspond à l'échantillonnage du signal dans l'espace fréquentiel
f =(0:N-1)*(fe/N); 
%Utilisation de la commande fftshift qui correspond a faire la TFD d'une manière rapide 
y = fft(x); 
subplot(2,3,2)
plot(f,abs(y));
%en utilisant la commande fftshift on obtient un spectre qui n'est pas centré sur 0
title("Spectre d'amplitude")
%3)-:
%Pour centré le spectre on doit créer une autre variable dont on va tracer la fonction fftshift qui fait le décalage
fshift = (-N/2:N/2-1)*(fe/N);
subplot(2,3,3)
%On multiplie par 2 pour avoir l'ampliture exact avant on obtient le module
%de Cn
plot(fshift,fftshift(2*abs(y)/N))
title("Le spectre d'amplitude centré")
%4)-:
noise = 5*randn(size(x));
subplot(2,3,4)
plot(noise)
title("Le signal noise")
%5)-:
sound(noise)
xnoise = x+noise;
sound(xnoise)
%6)-:
ybruit = fft(xnoise);
subplot(2,3,5)
plot(fshift,fftshift((abs(ybruit)*2)/N));
title("Le signal noise ")
%7)-:
figure;
noise2 = 20*randn(size(x));
xnoise2=x+noise2;
ybruit2 = fft(xnoise2);
plot(fshift,fftshift((abs(ybruit2))*2/N));
title("Le signal noise (2)")

%Après l'augementation de l'intensité du signal bruit on voit que le
%spectre de bruit est encombrer avec celui qui contient l'informatrion
%pertinante donc il sera très difficile d'extraire et filtrer le signal xnoise2

%% Analyse fréquentielle du chant du rorqual bleu

%1)-:
[whale,fe]=audioread("bluewhale.au");
chant = whale(2.45e4:3.10e4);
%2)-:
sound(chant,fe)
%3)-:
N = length(chant);
te = 1/fe;
t = (0:N-1)*(10*te);
figure;
subplot(2,1,1)
plot(t,chant)
title('Le signal whant')
y = abs(fft(chant)).^2/N; 
f = (0:floor(N/2))*(fe/N)/10;
subplot(2,1,2)
plot(f,y(1:floor(N/2)+1));
title('Le signal densité spectrale de puissance du signal')
