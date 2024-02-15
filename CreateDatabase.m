function [] = CreateDatabase()

dataBase = cell(200, 1);

for i = 1:200
    dataBase{i} = imread(['Database_logos/' int2str(i) '.jpg']);
end

save dataBase dataBase

%------------------------- Resize database ----------------------------

numImages = numel(dataBase);

targetSize = [50, 50];

for i = 1:numImages
    currentImage = dataBase{i};
    resizedImage = imresize(currentImage, targetSize);
    dataBase{i} = resizedImage;
end

save dataBase dataBase;

%----------------------- Create color database ------------------------

colorBase = cell(200, 1);

for i = 1:200
    
    currentImage = dataBase{i};
    
    labImage = rgb2lab(currentImage);
    
    L = labImage(:, :, 1);
    a = labImage(:, :, 2);
    b = labImage(:, :, 3);
    
    colorBase{i} = struct('L', L, 'a', a, 'b', b);
end

save colorBase colorBase

end

