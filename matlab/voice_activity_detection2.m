% детектор речи
function [speech] = voice_activity_detection2(frame_array)
    [~, N] = size(frame_array);
    speech = zeros(1, N);
    buf_speech = 0;
    buf_noise = 0;
    k = NamedConst.Number_frames;
    
    %нормированная краткосрочная энергия
    E_prim_thr = sum(frame_array(:, 1:k), 'all') / N/k;
    E_thr = E_prim_thr;
    %доминантная частота
    F_thr = 0;
    %тональный коэффициент
    SFM_thr = 0;
    for i = 1:k
        s = abs(fft(frame_array(:, i)));
        F_buf_thr = max(s);
        F_thr = max(F_buf_thr, F_thr);
        SFM_thr = SFM_thr + abs(10*log10((sum(log(s(:)))/N)/(sum(s(:))/N)));
    end
    SFM_thr = SFM_thr/k;

    for i = 1:N
        %нормированная краткосрочная энергия
        E_frame = sum(frame_array(:, i)) / N;
        %нормализованная автокорреляционная функция
        
        %доминантная частота
        S_frame = abs(fft(frame_array(:, i)));
        F_frame = max(S_frame);
        %тональный коэффициент
        SFM_frame = abs(10*log10((sum(log(S_frame(:)))/N)/(sum(S_frame(:))/N)));
        if i == 1
            E_min = E_frame;
            F_min = F_frame;
            SFM_min = SFM_frame;
            %E_thr = E_prim_thr * log10(E_min);
        elseif i <= 30
            E_min = min(E_min, E_frame);
            F_min = min(F_min, F_frame);
            SFM_min = min(SFM_min, SFM_frame);
            %E_thr = E_prim_thr * log10(E_min);
        end
        counter = 0;
        if E_frame > E_thr*5
            counter = counter + 1;
        end
        if F_frame > F_thr*1.7
            counter = counter + 1;
        end
        if SFM_frame> SFM_thr*1.1
            counter = counter + 1;
        end
        if counter > 0
            buf_speech = buf_speech + 1;
            if buf_speech == 5
                
            buf_noise = 0;
                speech(i - 4:i) = 1;
            elseif buf_speech > 5
                speech(i) = 1;
            else
                speech(i) = 0;
            end
        else
            %E_min = (buf_noise * E_min + E_frame)/(buf_noise + 1);
            buf_noise = buf_noise + 1;
            %E_thr = E_prim_thr * log10(E_min);
            
            if buf_noise == 10
            buf_speech = 0;
                speech(i - 9:i) = 0;
            elseif buf_noise > 10
                speech(i) = 0;
            else
                if i > k
                speech(i) = 1;
                end
            end
        end
    end

end

