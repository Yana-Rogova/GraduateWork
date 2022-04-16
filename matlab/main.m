k = 5;  % количество фреймов для оценки началного шума
frame_size = 1024; %размер фрейма

[input_signal, Fs] = audioread("voice.wav");
[frame_array, remainder] = signal_to_frames(input_signal, frame_size);
[noise] = start_noise(frame_array, k);
[frame_array, segSNR_array] = processing_frames(frame_array, noise);
output_signal = synthesis_signal(frame_array, remainder);
audiowrite("audio_output.wav", output_signal, Fs)
[~, N] = size(frame_array);
in_out_spectrogram(input_signal, output_signal, Fs, segSNR_array, frame_size, N);