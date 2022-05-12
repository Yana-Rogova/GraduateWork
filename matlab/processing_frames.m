% обработка сигнала фрейм за фреймом
function [frame_array, segSNR_array, speech] = processing_frames(frame_array, noise_abs, sub_noise_abs, Fs)
    [frame_size, N] = size(frame_array);
    segSNR_array = zeros(N, 1);
    speech = zeros(N, 1);
    Xmin = abs(fft(frame_array(:, 1)));
    Xmin = Xmin(1:frame_size/2+1);
    Xtmp = Xmin;
    p = zeros(1, frame_size/2+1);
    time_counter = 0;
    for i = 1:N
        [frame_array(:, i), new_noise_abs, sub_noise_abs, segSNR_array(i), speech(i), p, Xmin, Xtmp, time_counter] = ...
            processing_frame(frame_array(:, i), noise_abs, sub_noise_abs, Fs, p, Xmin, Xtmp, time_counter, i);
        noise_abs = new_noise_abs;
    end
end