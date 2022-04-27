% обработка одного фрейма
function [frame, new_noise_abs2, new_sub_noise_abs2, segSNR] = processing_frame(frame, noise_abs2, sub_noise_abs2, Fs)
    frame_size = NamedConst.Frame_size;
    N = frame_size/2 + 1;
    fft_frame = fft(frame, frame_size);
    theta = angle(fft_frame(1:N));
    input_signal_abs2 = abs(fft_frame(1:N)) .^ 2;
    
    [segSNR, speech] = snr(input_signal_abs2, noise_abs2);
    speech_abs2 = spectral_subtraction(input_signal_abs2, sub_noise_abs2, Fs);    
    %дополнение симметричной части ДПФ
    speech_abs2(frame_size/2+2:frame_size)=flipud(speech_abs2(2:frame_size/2));
    theta(frame_size/2+2:frame_size)= -1 * flipud(theta(2:frame_size/2));
    
    signal_to_ifft = sqrt(speech_abs2).*(cos(theta)+1j*(sin(theta)));
    frame = real(ifft(signal_to_ifft));
    
    % новая оценка мощности шума, если во фрейме отсутствует речь
    if (speech == 1)
        new_noise_abs2 = [];
        new_sub_noise_abs2 = [];
    else
        [new_noise_abs2, new_sub_noise_abs2] = new_noise(input_signal_abs2, noise_abs2, sub_noise_abs2, Fs);
    end
end
