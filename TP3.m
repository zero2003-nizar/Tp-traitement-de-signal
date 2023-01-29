clear all
close all
clc


%% Suppression du bruit provoqu� par les mouvements 
figure;
%1)-:
load("ecg.mat");
x=ecg;
%2)-:
fs=500;
N = length(x);
ts=1/fs;
t=(0:N-1)*ts;
subplot(1,3,1)
plot(t,x);
title("le signal ECG ");
%Puis faire un zoom sur une p�riode du signal
xlim([0.5 1.5])

%3)-:
y = fft(x); 
f2 = (-N/2:N/2-1)*(fs/N);
f =(0:N-1)*(fs/N);
subplot(1,3,2)
%spectre Amplitude centr�
plot(f2,fftshift(abs(y)))
title("spectre d'amplitude du signal ECG")
%suprimer les bruits des movements de corps
%Effectuer un tfdi d'un filtre passe-haut
filtre_haut = ones(size(x));
fc = 0.5;
index_h = ceil(fc*N/fs);
filtre_haut(1:index_h)=0;
% pour appliquer la sym�trie conjugu�
filtre_haut(N-index_h+1:N)=0;
%Application du filtrage
filtre=filtre_haut.*y;
% Inverse fast Fourier transform ifft()
ecg1=ifft(filtre,"symmetric");
%4)-:
subplot(1,3,3)
plot(t,ecg1);
title("signal filtre ecg1")
%Si on compare les signaux x(ecg) et ecg1 on voit que les
%les grandes andulation de signal a �t� supprim� l'andulation avec une
%grande p�riode alors le filtre passe haut a �t� bien appliqu�

 %% Suppression des interf�rences des lignes �lectriques 50Hz

%5)-:
figure;
%Notch filtre est utilis� pour supprimer une seule fr�quence ou une bande �troite de fr�quences
notch_filter = ones(size(x));
fc2 = 50;
index_h2 = ceil((fc2*N)/fs)+1; 
notch_filter(index_h2)= 0;
% pour appliquer la sym�trie conjugu�
notch_filter(N-index_h2+2)= 0;
% signal_a_filtre=fftshift((fft(ecg1)));
filtre2=notch_filter.*filtre;

%6)-:
ecg2=ifft(filtre2,"symmetric");
subplot(1,3,1)
plot(f2,fftshift(abs(filtre2)));
title("Spectre de Ecg2")
subplot(1,3,2)
plot(t,ecg2);
title("Signal  Ecg2")



%% Am�lioration du rapport signal sur bruit



%7)-:

%Filtrage pass-bas
figure;
filtre_bas = zeros(size(x));
%On change la fr�quence est on essaye d'approxim� le r�sultat
%a la represenatation du signal ecg sans bruit qui est represent� dans l'introduction
fc3 = 37;
index_h3 = ceil(fc3*N/fs);
filtre_bas(1:index_h3)=1;
% pour appliquer la sym�trie conjugu�
filtre_bas(N-index_h3+1:N)=1;
ecg3_freq =  filtre_bas.*fft(ecg2);
ecg3 = ifft(ecg3_freq,"symmetric");
%Apr�s plusieur teste on a pu determiner le filtre dans la
%frenquence 37hz alors meme si il y a encore du bruit dans cette
%fr�quence mais du fait qu'il est encombr� avec l'info pertinante si on
%essaye d'augementer la fr�quence de copure on va avoir une perte
%d'information qu'on peut visualiser avec la d�formation de des ondes P QRS
%et l'onde T qui constitue le signal ecg

%8)-:
 subplot(1,3,1)
plot(t,x)
xlim([0.5 1.5])
title('signal de depart ecg')
subplot(1,3,2)
plot(t,ecg3)
xlim([0.5 1.5])
title('signal ecg3')

%% Identification de la fr�quence cardiaque avec la fonction d�autocorr�lation

%9)-:
figure;
[acf,lags] = xcorr(ecg3,ecg3);
stem(lags/fs,acf)

