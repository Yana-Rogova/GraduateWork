% новая оценка мощности шума
function [new_noise_abs, time_counter, p, Xmin, Xtmp] = new_noise(input_signal_abs, prev_noise, prev_p, Xmin, Xtmp, time_counter, frame_number)
    alpha_d = NamedConst.noise_alpha_d;
    delta = NamedConst.noise_delta;
    alpha_p = NamedConst.noise_alpha_p;
    
    if time_counter >= 0.5
        time_counter = 0;
        Xmin = min(Xtmp, input_signal_abs);
        Xtmp = input_signal_abs;
    else
        Xmin = min(Xmin, input_signal_abs);
        Xtmp = min(Xtmp, input_signal_abs);
    end
    
    Sr = input_signal_abs(:) / Xmin(:);
    Sr = Sr(:, 1);
    
    if frame_number > 2
        p = alpha_p * prev_p;
        index = find(Sr > delta);
        if ~isempty(index)
            p(index) = p(index) + (1 - alpha_p);
        end
    else
        p = prev_p;
    end
    
    alpha = alpha_d + (1 - alpha_d) * p;
    new_noise_abs = alpha .* prev_noise + (1 - alpha) .* input_signal_abs;
    new_noise_abs = new_noise_abs(:, 1);
end

