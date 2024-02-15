

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

load colorBase.mat colorBase

numImages = numel(colorBase);
numRows = ceil(sqrt(numImages));
numCols = ceil(numImages / numRows);

figure;

for i = 1:numImages
    subplot(numRows, numCols, i);

    rgbImage = lab2rgb(cat(3, colorBase{i}.L, colorBase{i}.A, colorBase{i}.B));
    
    imshow(rgbImage);
    title(['Image ' num2str(i)]);
end




