function [] = CreateDatabase()

dataBase = cell(200, 1);

for i = 1:200
    currentImage = imread(['Database_logos/' int2str(i) '.jpg']);
    dataBase{i} = im2double(currentImage); 
end

save dataBase dataBase

numImages = numel(dataBase);

targetSize = [50, 50];

for i = 1:numImages
    currentImage = dataBase{i};
    resizedImage = imresize(currentImage, targetSize);
    dataBase{i} = resizedImage;
end

save dataBase dataBase;

end

