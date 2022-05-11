% детектор речи
function [speech, Gamma] = voice_activity_detection(in_signal_abs2, prev_in_abs2, prev_Gamma, noise_abs2, prev_noise_abs2)
    alpha = NamedConst.alpha;
    a01 = NamedConst.a01;
    a10 = NamedConst.a10;
    a00 = 1 - a01;
    a11 = 1 - a10;
    L = length(in_signal_abs2);
    lambda = zeros(1, L);
    noize_var = var(noise_abs2);
    prev_noize_var = var(prev_noise_abs2);
    for i = 1:L
        y = in_signal_abs2(i)/noize_var;
        
        if ~isempty(prev_in_abs2)
            %prev_in_var = var(prev_in_abs2);
            E = alpha * prev_in_abs2(i) / prev_noize_var;
            if (y - 1) > 0
                E = E + (1 - alpha) * (y - 1);
            end
        else
            E = 1 - y;
        end
        lambda(i) = exp(y * E /(E + 1)) / (E + 1);
    end
    Lambda = exp(1 / L * prod(log(lambda(:))));


    if ~isempty(prev_in_abs2)
        Gamma = (a01 + a11 * prev_Gamma) / (a00 + a10 * prev_Gamma) * Lambda;
    else
        Gamma = a01 / a10 * Lambda;
    end
    
    Z = a10 / a01 * Gamma;

    if Z > NamedConst.N_thr
        speech = 1;
    else
        speech = 0;
    end
    
%     SNR = 10 * log10 (sum(in_signal_abs2) / sum(noise_abs2));
% 
%     if SNR > NamedConst.N_thr
%         speech = 1;
%     else
%         speech = 0;
%     end
end

