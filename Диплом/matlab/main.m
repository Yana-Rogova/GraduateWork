
% close all; clear all;

str = 'piano_SNR15';
[input_signal, Fs] = audioread([str '.wav'], [1, 44100*7]);
input_signal = input_signal(:, 1);
[frame_array, remainder] = signal_to_frames(input_signal);
[noise] = start_noise(frame_array, NamedConst.Number_frames);
[frame_array, segSNR_array, speech] = processing_frames(frame_array, noise, Fs);
output_signal = synthesis_signal(frame_array, remainder);
audiowrite([str '_out.wav'], output_signal, Fs);
[~, N] = size(frame_array);
%a = audioread(['audiobook' '.wav']);
in_out_spectrogram(input_signal, output_signal, segSNR_array, N, Fs, speech);
% in_out_spectrogram(a, output_signal, segSNR_array, N, Fs, speech);



% 
% 
% 
% % Модель добавляет белый шум к сигналу
% file_name = '7_out';     % пмя исходного файла 1_16kHz_proc_3rd table 1_16kHz_proc_4rth table 6_16kHz ptichka_5s children_like_strawberries ptichka_5s
% [signal,fs] = audioread ([file_name '.wav']); % Входной сигнал
% 
% signal = signal(:, 1);
% snr_1 = 10;
% snr_2 = 15;
% 
% snr_1_ = num2str(snr_1);
% snr_2_ = num2str(snr_2);
% 
% x1 = awgn(signal,snr_1,'measured');
% x2 = awgn(signal,snr_2,'measured');
% 
% audiowrite([file_name '_SNR' snr_1_ '.wav' ],x1,fs);
% audiowrite([file_name '_SNR' snr_2_ '.wav' ],x2,fs);
% 
% figure;
% subplot (211);
% specgram(x1,512, fs , kaiser(512,7), 475);%, 512, fs,'yaxis');
% set(gca,'Clim', [-65 15]);
% xlabel('Time, s');
% ylabel('Frequency, Hz');
% title('SNR = 0 dB');
% set(gca, 'FontName', 'Times New Roman');
% set(gca, 'FontSize', 14);
% 
% subplot (212);
% specgram(x2,512, fs , kaiser(512,7), 475);%, 512, fs,'yaxis');
% set(gca,'Clim', [-65 15]);
% xlabel('Time, s');
% ylabel('Frequency, Hz');
% title('SNR = 5 dB');
% set(gca, 'FontName', 'Times New Roman');
% set(gca, 'FontSize', 14);