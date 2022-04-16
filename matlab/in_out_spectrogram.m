function [] = in_out_spectrogram(input_signal, output_signal, Fs, segSNR_array, frame_size, N)
    figure;
    subplot(121);
    specgram(input_signal, 512, Fs , kaiser(512,7), 475);
    set(gca,'Clim', [-65 15]);
    xlabel('Time, s');
    ylabel('Frequency, Hz');
    title('Input signal spectrogram');
    set(gca, 'FontName', 'Times New Roman', 'FontSize', 14);
        
    subplot(122);
    specgram(output_signal, 512, Fs , kaiser(512,7), 475);
    set(gca,'Clim', [-65 15]);
    xlabel('Time, s');
    ylabel('Frequency, Hz');
    title('Output signal spectrogram');
    set(gca, 'FontName', 'Times New Roman', 'FontSize', 14);
end

