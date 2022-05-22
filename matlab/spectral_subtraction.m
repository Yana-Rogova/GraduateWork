function [speech_abs2] = spectral_subtraction(input_signal_abs2, noise_abs, Fs)
    % субполосное спектральное вычитание
    betta = NamedConst.Substraction_betta;
    d = NamedConst.Substraction_delta;
    
    speech_abs2 = zeros(length(input_signal_abs2), 1);    
    bands = bands_borders(Fs);
    a = zeros(NamedConst.N_bands, 1);
    subSNR = zeros(NamedConst.N_bands, 1);
    
    for i = 1:NamedConst.N_bands
        sub_noise_abs2 = noise_abs(bands{i, 1}) .^2;
        subSNR(i) = snr(input_signal_abs2(bands{i, 1}), sub_noise_abs2);
        
        if (subSNR(i) < -5)
            a(i) = 8;
        elseif (subSNR(i) <= 20)
            a(i) = 5 - 3 / 20 * subSNR(i);
        else
            a(i) = 1;
        end
        
        speech_abs2(bands{i, 1}) = input_signal_abs2(bands{i, 1}) - ...
            a(i) * d(i) * sub_noise_abs2;
    end
    
    z = find(speech_abs2 < 0);
    if ~isempty(z)
         speech_abs2(z) = betta*input_signal_abs2(z);
    end
end

