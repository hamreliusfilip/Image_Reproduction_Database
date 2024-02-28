
% ------------------------- QUERY IMAGE ----------------------------

queryImageRGB = imread("Test_Images/Skriet.jpg");

numRows = size(queryImageRGB, 1);
numCols = size(queryImageRGB, 2);

if (numRows < 2000) && (numCols < 2000)
    disp('This image will be upscaled and might issue a worse result then a larger image would'); 
end 

queryImageRGB = imresize(queryImageRGB, [2000, 2000]); % Final image size
queryImageLAB = rgb2lab(queryImageRGB);

% ------------------------ INITIAL DATABASE -------------------------

CreateDatabase();

% --------------------- DATABASE OPTIMIZATION -----------------------


AmountOfImages = 200; % Max images you want in the final dataset, (200 availble).
Treshold = 0; % 3 being really similair, larger value = fewer images.

% Leave amount and treshold on 200 and 0 if opt 1 is turned off. 
% These still take effect. 

TurnOnOptimization_One = false; % Toggle on/off -> true/false
OptimizeDatabase(TurnOnOptimization_One,Treshold,AmountOfImages);

TurnOnOptimization_Two = false; % Toggle on/off -> true/false
OptimizeDatabase_OnQueryImage(queryImageRGB,TurnOnOptimization_Two); 

% ------------------------- REPRODUCTION ----------------------------

% Reproduction on color in CIELAB 
    imgFinalColor = Reproduction(queryImageLAB);

% Reproduction on structure with SSIM and color in CIELAB 
    % Uncomment to turn on structural similairty
    % imgFinalStructure = ReproductionOnStructure(queryImageLAB,queryImageRGB); 

% ---------------------------- PLOTTING -----------------------------

figure

subplot(1, 2, 1);
imshow(queryImageRGB);
title('Query Image');

subplot(1, 2, 2);
imshow(imgFinalColor);
title('Reproduction Image on colorspace');

%subplot(1, 2, 2);
%imshow(imgFinalStructure);
%title('Reproduction Image on structure');

% ----------------------- QUALITY & DATABASE ------------------------

% Uncomment if you want to see quality measures: SNR, MSE, S-CIELAB
    % Quality_Measures(queryImageRGB,imgFinalColor); 

% Uncomment if you want to see the database used for your image.
    % PlotDataBase(); 




