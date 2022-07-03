% синтез сигнала из фреймов
function [signal] = synthesis_signal(frame_array, remainder)
    [frame_size, N] = size(frame_array);
    half_frame = frame_size / 2;
    norm_win = half_frame / sum(hamming(frame_size)); % нормирующий коэффициент
    signal = zeros(half_frame * N, 1);
    
    signal(1:half_frame) = frame_array(1:half_frame, 1);
    for i = 2:N
        current_index = (i - 1) * half_frame + 1;
        signal(current_index:current_index + half_frame - 1, 1) = ...
            (frame_array(half_frame + 1:frame_size, i - 1) + ...
            frame_array(1:half_frame, i));
    end
    
    % восстановление изначальной длины сигнала
    if remainder == 0
        signal = vertcat(signal, frame_array(half_frame + 1:frame_size, N));
    else
        signal = vertcat(signal, frame_array(half_frame + 1:half_frame + remainder, N));
    end
    
    signal = signal * norm_win;
end