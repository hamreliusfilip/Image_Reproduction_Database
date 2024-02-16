

queryImageRGB = imread("Test_Images/Skriet.jpg"); 

numRows = size(queryImageRGB, 1);
numCols = size(queryImageRGB, 2);

if (numRows < 1000) && (numCols < 1000)
    disp('This image will be upscaled and might issue a worse result then a larger image would'); 
end 

TurnOnOptimization = false; % Toggle true/false for database optimization

queryImageRGB = imresize(queryImageRGB, [5000, 5000]);
queryImageLAB = rgb2lab(queryImageRGB);

CreateDatabase();

OptimizeDatabase(TurnOnOptimization);





OptimizeDatabase_OnQueryImage(queryImageRGB); 

imgFinal = Reproduction(queryImageLAB);

figure
subplot(1, 2, 1);
imshow(queryImageRGB);
title('Query Image');

subplot(1, 2, 2);
imshow(imgFinal);
title('Reproduction Image');

% PlotDataBase(); % Uncomment if you want to see the database used for your image.




