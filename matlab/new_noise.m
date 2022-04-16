% функция, производящая новую оценку мощности шума
function [new_noise_abs2] = new_noise(input_signal_abs2, noise_abs2)
    gamma = 0.9;
    new_noise_abs2 = gamma * noise_abs2 + (1 - gamma) * input_signal_abs2;
end

