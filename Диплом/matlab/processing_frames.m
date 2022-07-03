% обработка сигнала фрейм за фреймом
function [frame_array, segSNR_array, speech] = processing_frames(frame_array, noise_abs, Fs)
    [frame_size, N] = size(frame_array);
    segSNR_array = zeros(N, 1);
    speech = zeros(N, 1);
    Xmin = abs(fft(frame_array(:, 1)));
    Xmin = Xmin(1:frame_size/2+1);
    Xtmp = Xmin;
    p = zeros(1, frame_size/2+1);
    time_counter = 0;
    
    %определение фреймов, содержащих речь
    %speech = voice_activity_detection2(frame_array);
    noise_abs2 = noise_abs.^2;
    buf_speech = 0;
    buf_noise = 0;
    
    %обработка фрейм за фреймом
    for i = 1:N
        [speech, buf_speech, buf_noise] = voice_activity_detection1(frame_array(:, i), noise_abs2, buf_speech, buf_noise, speech, i);
        [frame_array(:, i), new_noise_abs, segSNR_array(i), speech(i), p, Xmin, Xtmp, time_counter] = ...
            processing_frame(frame_array(:, i), noise_abs, Fs, p, Xmin, Xtmp, time_counter, i, speech(i));
        noise_abs = new_noise_abs;
        noise_abs2 = noise_abs.^2;
    end
end