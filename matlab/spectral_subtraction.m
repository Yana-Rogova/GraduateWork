function [speech_abs2] = spectral_subtraction(input_signal_abs2, noise_abs2)
    speech_abs2 = input_signal_abs2 - noise_abs2;
    z = find(speech_abs2 < 0);
    if~isempty(z)
         speech_abs2(z) = 0.002*noise_abs2(z);
    end
end

