% обработка одного фрейма
function [frame, new_noise_abs, segSNR, speech, p, Xmin, Xtmp, time_counter] = processing_frame(frame, noise_abs, Fs, p, Xmin, Xtmp, time_counter, i, speech)
    frame_size = NamedConst.Frame_size;
    N = frame_size/2 + 1;
    fft_frame = fft(frame, frame_size);
    theta = angle(fft_frame(1:N));
    input_signal_abs2 = abs(fft_frame(1:N)) .^ 2;
    input_signal_abs = abs(fft_frame(1:N));
    noise_abs2 = noise_abs.^2;
    
    segSNR = snr(input_signal_abs2, noise_abs2);
    %[speech] = voice_activity_detection1(frame, noise_abs2);
    [speech_abs2] = spectral_subtraction(input_signal_abs2, noise_abs, Fs);    
    %дополнение симметричной части ДПФ
    signal_to_ifft = sqrt(speech_abs2).*(cos(theta)+1j*(sin(theta)));
    signal_to_ifft(frame_size/2+2:frame_size) = flipud(conj(signal_to_ifft(2:frame_size/2)));
    
    frame = real(ifft(signal_to_ifft));
    time_counter = time_counter + frame_size / Fs;
    % новая оценка мощности шума, если во фрейме отсутствует речь
    if (speech == 1)
        new_noise_abs = noise_abs;
    else
        [new_noise_abs, time_counter, p, Xmin, Xtmp] = new_noise(input_signal_abs, noise_abs, p, Xmin, Xtmp, time_counter, i);
    end
end
