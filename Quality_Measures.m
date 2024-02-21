function [] = Quality_Measures(Query_Image, Final_Image)

disp('Calculating quality measures...'); 

% Ensure the images are of the same type
Query_Image = im2double(Query_Image); 
Final_Image = im2double(Final_Image);

% SNR - Signal to Noise Ratio 
SNR_Value = snr(Query_Image, Query_Image - Final_Image); 
fprintf('Signal-to-Noise Ratio between original and reproduction image: %d\n', SNR_Value);

% MSE - Mean Squared Error
MSE_Value = immse(Query_Image, Final_Image); 
fprintf('Mean Squared Error between original and reproduction image: %d\n', MSE_Value);

% S-CIELAB
ppi = 132; % 15 tum, 1680 x 1050 (Macbook pro 15 inch 2019) 
d = 20; % 20 inches from screen
sampPerDeg = ppi * d * tan(pi/180);
whitepoint = [95.05, 100, 108.9]; 
format = 'xyz'; 

Query_Image_CIEXYZ = rgb2xyz(Query_Image); 
Final_Image_CIEXYZ = rgb2xyz(Final_Image);

S_CIELAB_Value = scielab(sampPerDeg, Query_Image_CIEXYZ, Final_Image_CIEXYZ, whitepoint, format);

Result_S_CIELAB_Value = mean(mean(S_CIELAB_Value)); 
fprintf('S_CIELAB value between original and reproduction image: %d\n', Result_S_CIELAB_Value);

end

