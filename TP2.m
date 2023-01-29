clear all
close all
clc
%% Jeux de mots
%1)-:

[x,fs]=audioread("C:\Users\PC\Desktop\tp\phrase.opus");

%2)-:
N = length(x)
ts = 1/fs
t = (0:N-1)*ts
sound(x,fs)
plot(t,x)

%3)-:

sound(x,2*fs)
sound(x,fs/2)


%Question 4:
rien_ne_sert_de = x(5055:76000);
plot(rien_ne_sert_de);
title('phrase');

%Question 5:


rien_ne_sert_de=x(5055:76000);
sound(rien_ne_sert_de,fs); 

%Question 6:
rien_ne_sert_de=x(5055:76000);
courir=x(76000:95395);
il_faut = x(95395:141652);
partir_a_point =x(100000:152505);

%Question 7:
vector =[rien_ne_sert_de ; partir_a_point; il_faut; courir];
sound(vector,fs);



