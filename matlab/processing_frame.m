% функция обработки фрейма
function [frame, new_noise_abs2, segSNR] = processing_frame(frame, noise_abs2)
    [frame_size, ~] = size(frame);
    
    fft_frame = fft(frame, frame_size);
    theta = angle(fft_frame);
    input_signal_abs2 = abs(fft_frame) .^ 2;
    
    [segSNR, speech] = snr(input_signal_abs2, noise_abs2);
    speech_abs2 = spectral_subtraction(input_signal_abs2, noise_abs2);    
    %speech_abs2(frame_size/2+2:frame_size)=flipud(speech_abs2(2:frame_size/2));
    signal_to_ifft = sqrt(speech_abs2).*(cos(theta)+1j*(sin(theta)));
    frame = real(ifft(signal_to_ifft));
    
    % новая оценка мощности шума, если во фрейме отсутствует речь
    if (speech == 1)
        new_noise_abs2 = [];
    else
        new_noise_abs2 = new_noise(input_signal_abs2, noise_abs2);
    end
end

% function [frame, new_noise_abs2] = processing_frame(frame, noise_abs2)
%     new_noise_abs2 = [];
%     frame = frame .* 10;
% end