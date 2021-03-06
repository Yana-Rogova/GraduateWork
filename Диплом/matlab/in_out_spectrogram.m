function [] = in_out_spectrogram(input_signal, output_signal, segSNR_array, N, Fs, speech)
    % построение гистограмм
    
    frame_size = NamedConst.Frame_size;
    % исходный сигнал
    figure;
    subplot(5, 2, [1, 3, 5]);
    specgram(input_signal, 512, Fs , kaiser(512,7), 475);
    set(gca,'Clim', [-65 15]);
    graph_labels(["Спектрограмма зашумленного сигнала (ОСШ = 15 дБ)" "Время, с" "Частота, Гц"]);
    
    %figure; subplot(211);
    subplot(5,2,7);
    stem((1:N)*frame_size/2/Fs, segSNR_array, 'Marker', 'none');
    graph_labels(["ОСШ по фреймам зашумленного сигнала" "Время, с" "ОСШ, дБ"]);
    axis ([frame_size/2/Fs, N*frame_size/2/Fs, -5, 50]);
    
%     subplot(5,2,9); %subplot(212);
%     stem((1:length(input_signal))/Fs, input_signal, 'Marker', 'none');
%     graph_labels(["Исходный сигнал" "Время, с" "Амплитуда, дБ"]);
%     axis([frame_size/2/Fs, N*frame_size/2/Fs, -0.75, 0.75]);
%     speech_detector(0.5, N, speech, Fs);
 
    % очищенный сигнал
    % получение значений ОСШ для очщенного сигнала    
    buf = signal_to_frames(output_signal);
    [noise] = start_noise(buf, 5);
    [~, segSNR_array_out] = processing_frames(buf, noise, Fs);
    
    %figure;
    subplot(5, 2, [2, 4, 6]);
    specgram(output_signal, 512, Fs , kaiser(512,7), 475);
    set(gca,'Clim', [-65 15]);
    graph_labels(["Спектрограмма очищенного сигнала (ОСШ = 15 дБ)" "Время, с" "Частота, Гц"]);
    
    %figure;
    subplot(5, 2, 8);%subplot(211);
    stem((1:N)*frame_size/2/Fs, segSNR_array_out(1:N), 'Marker', 'none');
    graph_labels(["ОСШ по фреймам очищенного сигнала" "Время, с" "ОСШ, дБ"]);
    axis ([frame_size/2/Fs, N*frame_size/2/Fs, -5, 70]);
    
%     subplot(5, 2, 10);%subplot(212);    
%     stem((1:length(output_signal))/Fs, output_signal, 'Marker', 'none');
%     graph_labels(["Очищенный сигнал" "Время, с" "Амплитуда, дБ"]);    
%     axis ([frame_size/2/Fs, N*frame_size/2/Fs, -0.75, 0.75]);
%     speech_detector(0.5, N, speech, Fs);    
end