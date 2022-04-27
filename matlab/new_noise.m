% новая оценка мощности шума
function [new_noise_abs2, new_sub_noise_abs2] = new_noise(input_signal_abs2, noise_abs2, sub_noise_abs2, Fs)
    gamma = NamedConst.Noise_gamma;
    bands = bands_borders(Fs);
    
    new_noise_abs2 = gamma * noise_abs2 + (1 - gamma) * input_signal_abs2;
    for i = 1:NamedConst.N_bands
        new_sub_noise_abs2{i, 1} = gamma * sub_noise_abs2{i, 1} + ...
            (1 - gamma) * input_signal_abs2(bands{i, 1});
    end
end

