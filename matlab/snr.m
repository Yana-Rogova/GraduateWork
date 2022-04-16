%функция, вычисляющая значение отношения сигнал/шум
function [SNR, speech] = snr(input_signal_abs2, noise_abs2)
    SNR = 10 * log10 (sum(input_signal_abs2) / sum(noise_abs2));
    
    % определения наличия речи во фрейме
    if SNR > NamedConst.N_thr
        speech = 1;
    else
        speech = 0;
    end
end