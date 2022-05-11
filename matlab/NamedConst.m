classdef NamedConst
   properties (Constant)
      N_thr = 0.9            % Пороговое значение присутствия речи
      Frame_size = 4098      % Размер фрейма
      Number_frames = 5     % Количество фреймов для определения начального шума
      
      Noise_gamma = 0.95;   %
      
      N_bands = 3
      Substraction_delta = [1 3 2.5 5.5 7.8];
      Substraction_betta = 0.001;
      
      a01 = 0.2;
      a10 = 0.1;
      alpha = 0.917;
   end
end