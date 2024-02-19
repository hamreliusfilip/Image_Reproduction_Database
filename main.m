
% ------------------------- QUERY IMAGE ----------------------------

queryImageRGB = imread("Test_Images/Night.jpg"); 

numRows = size(queryImageRGB, 1);
numCols = size(queryImageRGB, 2);

if (numRows < 1000) && (numCols < 1000)
    disp('This image will be upscaled and might issue a worse result then a larger image would'); 
end 

queryImageRGB = imresize(queryImageRGB, [2000, 2000]); % Final image
queryImageLAB = rgb2lab(queryImageRGB);

% ------------------------ INITIAL DATABASE -------------------------

CreateDatabase();

% --------------------- DATABASE OPTIMIZATION -----------------------

TurnOnOptimization_One = true; % Toggle on/off -> true/false
AmoundOfImages = 50; % Max images you want in the final dataset, (200 availble).
Treshold = 55; % 3 being really similair, larger value = fewer images.
OptimizeDatabase(TurnOnOptimization_One,Treshold,AmoundOfImages);

TurnOnOptimization_Two = false; % Toggle on/off -> true/false
OptimizeDatabase_OnQueryImage(queryImageRGB,TurnOnOptimization_Two); 

% ------------------------- REPRODUCTION ----------------------------

imgFinal = Reproduction(queryImageLAB);

% ---------------------------- PLOTTING -----------------------------

figure
subplot(1, 2, 1);
imshow(queryImageRGB);
title('Query Image');

subplot(1, 2, 2);
imshow(imgFinal);
title('Reproduction Image');

% ----------------------- QUALITY & DATABASE ------------------------

% Uncomment if you want to see quality measures: SNR, MSE, S-CIELAB
% Quality_Measures(queryImageRGB,imgFinal); 

% Uncomment if you want to see the database used for your image.
PlotDataBase(); 




