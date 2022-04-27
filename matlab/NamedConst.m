classdef NamedConst
   properties (Constant)
      N_thr = 5             % Пороговое значение присутствия речи
      Frame_size = 512      % Размер фрейма
      Number_frames = 5     % Количество фреймов для определения начального шума
      
      Noise_gamma = 0.9;
      
      N_bands = 3
      Substraction_delta = [1 2.5 1.5];
      Substraction_betta = 0.002;
   end
end