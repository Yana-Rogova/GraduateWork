% обработка сигнала фрейм за фреймом
function [frame_array, segSNR_array] = processing_frames(frame_array, noise_abs2, sub_noise_abs2, Fs)
    [~, N] = size(frame_array);
    segSNR_array = zeros(N, 1);
    Gamma = [];
    prev_in_abs2 = [];
    prev_noise_abs2 = noise_abs2;
    for i = 1:N
        [frame_array(:, i), new_noise_abs2, sub_noise_abs2, segSNR_array(i), Gamma] = ...
            processing_frame(frame_array(:, i), prev_in_abs2, noise_abs2, prev_noise_abs2, sub_noise_abs2, Fs, Gamma);
        prev_in_abs2 = frame_array(:, i);
        prev_noise_abs2 = noise_abs2;
        noise_abs2 = new_noise_abs2;
    end
end