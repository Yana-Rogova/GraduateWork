% детектор речи
function [speech] = voice_activity_detection1(in_signal_abs2, noise_abs2)
    SNR = 10 * log10 (sum(in_signal_abs2) / sum(noise_abs2));

    if SNR > NamedConst.N_thr
        speech = 1;
    else
        speech = 0;
    end
end

