clear all

s_name = '7_out';
n_name = [s_name '_SNR15'];
cl_name = [n_name '_out'];
SNR = 15;

[start_signal, Fs] = audioread([s_name '.wav']);
[cl_signal, ~] = audioread([cl_name '.wav']);
noise = awgn(start_signal,SNR,'measured');
% snr_start_noise = snr(noize_signal,noize)
% snr_clear_noise = snr(cl_signal,noize)

noisePower = sum(noise.^2,1)/size(noise,1); %% мощность шума
signalPower = sum(start_signal.^2,1)/size(start_signal,1); %% мощность входного сигнала

snr_init = 10*log10(signalPower./noisePower) %% исходный SNR
noisePowerdB = 10*log10(noisePower); %% мощность шума в дБ
signalPowerdB = 10*log10(signalPower); %% мощность вх. сигнала в дБ

scaleFactor = sqrt(signalPower./(noisePower*(10^(SNR/10)))); %% коэф-т

noise = noise.*scaleFactor; %% умножение на коэф-т
noisePower = sum(noise.^2,1)/size(noise,1); %% мощность шума в дБ (после scale)
snr_res = 10*log10(signalPower./noisePower) %% итоговый SNR

noize_signal = start_signal + noise;

clearsignalPower = sum(cl_signal.^2,1)/size(cl_signal,1); %% мощность выходного сигнала
snr_res_cl = 10*log10(clearsignalPower./noisePower) %% итоговый SNR
