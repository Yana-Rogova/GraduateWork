% вычисление отношения сигнал/шум
function [SNR] = snr(input_signal_abs2, noise_abs2)
    SNR = 10 * log10 (sum(input_signal_abs2) / sum(noise_abs2));
end