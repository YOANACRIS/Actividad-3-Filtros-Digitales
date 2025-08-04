%% Filtros Digitales en MATLAB
% Autor: Yoana Cristina Escobedo Castillo
% Fecha: 02 08 2025

% Parámetros generales
Fs = 1000;               % Frecuencia de muestreo (Hz)
t = 0:1/Fs:1-1/Fs;       % Vector de tiempo de 1 segundo
x = sin(2*pi*50*t) + sin(2*pi*200*t) + randn(size(t));  % Señal original

% Graficar señal original
figure; plot(t, x);
title('Señal Original con Ruido');
xlabel('Tiempo (s)'); ylabel('Amplitud');

%% Filtro Pasa Bajos - Butterworth
fc_lp = 100;  % Frecuencia de corte (Hz)
[b_lp, a_lp] = butter(6, fc_lp/(Fs/2));
y_lp = filter(b_lp, a_lp, x);
figure; plot(t, y_lp);
title('Señal Filtrada - Pasa Bajos Butterworth');
xlabel('Tiempo (s)'); ylabel('Amplitud');

%% Filtro Pasa Altos - Chebyshev Tipo I
fc_hp = 150;
[b_hp, a_hp] = cheby1(4, 1, fc_hp/(Fs/2), 'high');
y_hp = filter(b_hp, a_hp, x);
figure; plot(t, y_hp);
title('Señal Filtrada - Pasa Altos Chebyshev I');
xlabel('Tiempo (s)'); ylabel('Amplitud');

%% Filtro Pasa Banda - FIR con Ventana
f1 = 80; f2 = 180;
order = 50;
b_pb = fir1(order, [f1 f2]/(Fs/2), 'bandpass', hamming(order+1));
y_pb = filter(b_pb, 1, x);
figure; plot(t, y_pb);
title('Señal Filtrada - Pasa Banda FIR');
xlabel('Tiempo (s)'); ylabel('Amplitud');

%% FFT - Análisis en frecuencia
N = length(x);
f = Fs*(0:(N/2))/N;

X = abs(fft(x))/N;
Y_lp = abs(fft(y_lp))/N;
Y_hp = abs(fft(y_hp))/N;
Y_pb = abs(fft(y_pb))/N;

figure; plot(f, X(1:N/2+1));
title('Espectro de Frecuencia - Señal Original');

figure; plot(f, Y_lp(1:N/2+1));
title('Espectro - Señal Pasa Bajos');

figure; plot(f, Y_hp(1:N/2+1));
title('Espectro - Señal Pasa Altos');

figure; plot(f, Y_pb(1:N/2+1));
title('Espectro - Señal Pasa Banda');
