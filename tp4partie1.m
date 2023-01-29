clear all
close all
clc

%partie 1
Te = 5*1e-4;
f1 = 500;
f2 = 400;
f3 = 50;
t = 0:Te:5-Te;
fe = 1/Te;
N = length(t);
fshift = (-N/2:N/2-1)*(fe/N);
f = (0:N-1)*(fe/N);
x = sin(2*pi*f1*t)+sin(2*f2*pi*t)+sin(2*pi*f3*t);
y = fft(x);

k = 1;
wc = 50;
wc1 = 500;
wc2 = 1000;

h = (k*1j*((2*pi*f)/wc))./(1+1j*((2*pi*f)/wc));
h1 = (k*1j*((2*pi*f)/wc1))./(1+1j*((2*pi*f)/wc1));
h2 = (k*1j*((2*pi*f)/wc2))./(1+1j*((2*pi*f)/wc2));

G = 20*log(abs(h));     %diagramme de bode
G1 = 20*log(abs(h1));
G2 = 20*log(abs(h2));

P = angle(h);
P1 = angle(h1);
P2 = angle(h2);

subplot(3,1,1)
semilogx(abs(h))
plot(abs(h))
legend("Module de h(t)")

subplot(3,1,2)
semilogx(f,G,f,G1,f,G2);
title("Diagramme de Bode")
xlabel("rad/s")
ylabel("decibel")
legend("G : wc=50","G1 : wc=500","G2 : wc=1000")

subplot(3,1,3)
semilogx(f,P,f,P1,f,P2)



