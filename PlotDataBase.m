function [] = PlotDataBase()

load colorBase.mat colorBase

numImages = numel(colorBase);
numRows = ceil(sqrt(numImages));
numCols = ceil(numImages / numRows);

disp('Plotting database used...'); 

figure;

for i = 1:numImages
    subplot(numRows, numCols, i);

    rgbImage = lab2rgb(cat(3, colorBase{i}.L, colorBase{i}.A, colorBase{i}.B));
    
    imshow(rgbImage);
    title(['Image ' num2str(i)]);
end

sgtitle('Images used for the Reproduction Image');

end

