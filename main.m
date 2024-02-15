

queryImageRGB = imread("Database_logos/32.jpg"); 

numRows = size(queryImageLab, 1);
numCols = size(queryImageLab, 2);

if (numRows < 1000) && (numCols < 1000)
    disp('This image will be upscaled and might issue a worse result then a larger image would'); 
end 

TurnOnOptimization = true; % Toggle true/false for database optimization

queryImageRGB = imresize(queryImageRGB, [1000, 1000]);

queryImageLAB = rgb2lab(queryImageRGB);

CreateDatabase();

OptimizeDatabase(TurnOnOptimization);

imgFinal = Reproduction(queryImageLAB);

subplot(1, 2, 1);
imshow(queryImageRGB);
title('Query Image');

subplot(1, 2, 2);
imshow(imgFinal);
title('Reproduction Image');





