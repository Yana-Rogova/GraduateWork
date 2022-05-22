function [] = speech_detector(height, N, speech, Fs)
    % функция, показывающая на графике присутсвие речи во фрейме
    detector_array = zeros(N, 1);
    
%     speech = find(segSNR_array > NamedConst.N_thr);
%     if ~isempty(speech)
%     	detector_array(speech) = height;
%     end

    speech_c = find(speech > 0);
    if ~isempty(speech)
    	detector_array(speech_c) = height;
    end
    

    dbl_detector_array = zeros(2*N-1, 1);
    dbl_detector_array(1:2:2*N-1) = detector_array(1:N);
    dbl_detector_array(2:2:2*N-1) = detector_array(2:N);
    
    hold on;    
    stairs((1:0.5:N)*NamedConst.Frame_size/2/Fs, dbl_detector_array, 'LineWidth', 1);
end

