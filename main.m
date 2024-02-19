
queryImageRGB = imread("Test_Images/Night.jpg"); 

numRows = size(queryImageRGB, 1);
numCols = size(queryImageRGB, 2);

if (numRows < 1000) && (numCols < 1000)
    disp('This image will be upscaled and might issue a worse result then a larger image would'); 
end 

queryImageRGB = imresize(queryImageRGB, [1000, 1000]);
queryImageLAB = rgb2lab(queryImageRGB);

CreateDatabase();

TurnOnOptimization = false; % Toggle true/false for database optimization
OptimizeDatabase(TurnOnOptimization);

% Uncomment to remove optimization odatabase on query image
OptimizeDatabase_OnQueryImage(queryImageRGB); 

imgFinal = Reproduction(queryImageLAB);

figure
subplot(1, 2, 1);
imshow(queryImageRGB);
title('Query Image');

subplot(1, 2, 2);
imshow(imgFinal);
title('Reproduction Image');

PlotDataBase(); % Uncomment if you want to see the database used for your image.





