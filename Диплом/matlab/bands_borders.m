function [bands] = bands_borders(Fs)
    % разбиение ДПФ на полосы по частоте
    fs_fft = (0:Fs/(NamedConst.Frame_size+1):Fs/2)';
    freq = Fs / (2^NamedConst.N_bands);
    bands{1, 1} = 1:length(fs_fft);
    for i = 2:NamedConst.N_bands
        num = find(fs_fft > freq);
        if ~isempty(num)
            bands{i, 1} = num;
            bands{i - 1, 1} = bands{i - 1, 1}(1):bands{i, 1}(1)-1;
        else
            break;
        end
        freq = freq * 2;
    end
end

