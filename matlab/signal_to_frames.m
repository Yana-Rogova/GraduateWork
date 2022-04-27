% разбиение сигнала на фреймы
function [frame_array, remainder] = signal_to_frames(signal)
    frame_size = NamedConst.Frame_size;
    half_frame = frame_size / 2;
    remainder = mod(length(signal), half_frame);
    N = fix(length(signal) / half_frame); % деление без остатка
    frame_array = zeros(frame_size, N);
    window = hamming(frame_size);
    
    if remainder == 0
        N = N - 1;
    else
        %дополнение сигнала нулями до размера, кратного половине фрейма
        signal = vertcat(signal, zeros(half_frame - remainder, 1));
    end
    
    for i = 0:N - 1
        current_index = i * half_frame + 1;
        frame_array(:, i + 1) = signal(current_index:current_index + frame_size - 1, 1);
    end
    frame_array = window .* frame_array;
end