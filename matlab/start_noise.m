% оценка начальной мощности шума
function [noise_abs] = start_noise(frame_array, k)
    [frame_size, ~] = size(frame_array);
    N = frame_size/2 + 1;
    noise_abs = zeros(N, 1);

    for i = 1:k
        current_frame = abs(fft(frame_array(:, i), frame_size));
        noise_abs = noise_abs + current_frame(1:N);
    end
    
    noise_abs = (noise_abs / k);
end