%close all; clear all;

[input_signal, Fs] = audioread("white_noise.wav");
[frame_array, remainder] = signal_to_frames(input_signal);
[noise, sub_noise] = start_noise(frame_array, NamedConst.Number_frames, Fs);
[frame_array, segSNR_array, speech] = processing_frames(frame_array, noise, sub_noise, Fs);
output_signal = synthesis_signal(frame_array, remainder);
audiowrite("audio_output.wav", output_signal, Fs);
[~, N] = size(frame_array);
in_out_spectrogram(input_signal, output_signal, segSNR_array, N, Fs, speech);
