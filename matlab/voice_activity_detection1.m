% детектор речи
% function [speech, buf_speech, buf_noise] = voice_activity_detection1(in_signal, noise_abs2, buf_speech, buf_noise, speech, i)
%     in_signal_abs2 = fft(in_signal);
%     in_signal_abs2 = abs(in_signal_abs2(1:length(in_signal_abs2)/2+1)).^2;
%     
%     SNR = snr(in_signal_abs2, noise_abs2);
% 
%     if SNR > NamedConst.N_thr
%         speech = 1;
%     else
%         speech = 0;
%     end
% 
% end

% детектор речи
function [speech, buf_speech, buf_noise] = voice_activity_detection1(in_signal, noise_abs2, buf_speech, buf_noise, speech, i)
in_signal_abs2 = fft(in_signal);
in_signal_abs2 = abs(in_signal_abs2(1:length(in_signal_abs2)/2+1)).^2;
    SNR = snr(in_signal_abs2, noise_abs2);
    if SNR > NamedConst.N_thr
        %speech = 1;
        buf_speech = buf_speech + 1;
        if buf_speech == 5
            buf_noise = 0;
            speech(i - 4:i) = 1;
        elseif buf_speech > 5
            speech(i) = 1;
            buf_noise = 0;
        else
            speech(i) = 0;
        end
    else
        %speech = 0;
        buf_noise = buf_noise + 1;
        if buf_noise == 10
            buf_speech = 0;
            speech(i - 9:i) = 0;
        elseif buf_noise > 10
            speech(i) = 0;
            buf_speech = 0;
        else
            if i > 10
                speech(i) = 1;
            else
                speech(i) = 0;
            end
        end
    end
    

    
end

