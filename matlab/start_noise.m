% оценка начальной мощности шума
function [noise_abs2] = start_noise(frame_array, k)
    [frame_size, ~] = size(frame_array);
    noise_abs2 = zeros(frame_size, 1);
    nFFT = 2 ^ (nextpow2(frame_size));
    for i = 1:k
        currenr_frame = abs(fft(frame_array(:, i), nFFT));
        noise_abs2 = noise_abs2 + currenr_frame;
    end
    noise_abs2 = (noise_abs2 / k) .^ 2;
end