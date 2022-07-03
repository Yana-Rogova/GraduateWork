clear all

s_name = 'audiobook';
s1_name = [s_name, '_out'];
n_name = [s_name '_SNR15'];
cl_name = [n_name '_out'];
SNR = 15;

[start_signal, Fs] = audioread([s_name '.wav'], [1, 44100*7]);
start_signal = start_signal(:, 1);
[cl_start_signal, ~] = audioread([s1_name '.wav'], [1, 44100*7]);
cl_start_signal = cl_start_signal(:, 1);
[cl_signal, ~] = audioread([cl_name '.wav'], [1, 44100*7]);
cl_signal = cl_signal(:, 1);
noise = awgn(start_signal,SNR,'measured');
% snr_start_noise = snr(noize_signal,noize)
% snr_clear_noise = snr(cl_signal,noize)

noisePower = sum(noise.^2,1)/size(noise,1); %% мощность шума
signalPower = sum(start_signal.^2,1)/size(start_signal,1); %% мощность входного сигнала

snr_init = 10*log10(signalPower./noisePower); %% исходный SNR
noisePowerdB = 10*log10(noisePower); %% мощность шума в дБ
signalPowerdB = 10*log10(signalPower); %% мощность вх. сигнала в дБ

scaleFactor = sqrt(signalPower./(noisePower*(10^(SNR/10)))); %% коэф-т

noise = noise.*scaleFactor; %% умножение на коэф-т
noisePower = sum(noise.^2,1)/size(noise,1); %% мощность шума в дБ (после scale)
noisePowerdB = 10*log10(noisePower); %% мощность шума в дБ

snr_res = 10*log10(signalPower./noisePower) %% итоговый SNR

res_noise = start_signal - cl_signal;
resnoisePower = sum(res_noise.^2,1)/size(res_noise,1); %% мощность шума в дБ (после scale)
resnoisePowerdB = 10*log10(resnoisePower); %% мощность шума в дБ

clPower = abs(10*log10(sum(cl_signal.^2,1)/size(cl_signal,1)));
snr_after = 10*log10(clPower./resnoisePower) %% итоговый SNR


% 
% db1 = noisePowerdB;
% db2 = signalPowerdB;
% 
% snr_before = db2-db1
% 
% 
% y1 = cl_start_signal;
% y2 = cl_signal;
% z = y2-y1;
% 
% zPowerdB = 10*log10(sum(z.^2,1)/size(z,1));
% speechPdB = 10*log10(sum(y1.^2,1)/size(y1,1));
% snr_after = speechPdB - zPowerdB

