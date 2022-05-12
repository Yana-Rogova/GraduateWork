% оценка начальной мощности шума
function [noise_abs, sub_noise_abs] = start_noise(frame_array, k, Fs)
    frame_size = NamedConst.Frame_size;
    N = frame_size/2 + 1;
    noise_abs = zeros(N, 1);
    
    bands = bands_borders(Fs);
    
    for i = 1:NamedConst.N_bands
        sub_noise_abs{i, 1} = zeros(length(bands{i, 1}), 1);
    end

    for i = 1:k
        current_frame = abs(fft(frame_array(:, i), frame_size));
        noise_abs = noise_abs + current_frame(1:N);
        for j = 1:NamedConst.N_bands
            sub_noise_abs{j, 1} = sub_noise_abs{j, 1} + current_frame(bands{j, 1});
        end
    end
    
    noise_abs = (noise_abs / k);
    for i = 1:NamedConst.N_bands
        sub_noise_abs{i, 1} = (sub_noise_abs{i, 1} / k);
    end
end