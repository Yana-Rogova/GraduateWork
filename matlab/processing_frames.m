% функция обработки сигнала фрейм за фреймом
function [frame_array, segSNR_array] = processing_frames(frame_array, noise_abs2)
    [~, N] = size(frame_array);
    segSNR_array = zeros(N, 1);
    for i = 1:N
        [frame_array(:, i), new_noise_abs2, segSNR_array(i)] = ...
            processing_frame(frame_array(:, i), noise_abs2);
        if ~isempty(new_noise_abs2)
            % новая оценка мощности шума
            noise_abs2 = new_noise_abs2;
        end
    end
end