function [rgbImage] = Reproduction(queryImageLab)

load colorBase.mat colorBase

disp('Calculating reproduction image on colorspace...');

sizeDatabase = numel(colorBase); 

targetColors = zeros(200, 3);

% Target colors in all the regions
for q = 1:sizeDatabase
    targetColors(q, 1) = mean(colorBase{q}.L(:));
    targetColors(q, 2) = mean(colorBase{q}.A(:));
    targetColors(q, 3) = mean(colorBase{q}.B(:));
end

queryImageLab = im2double(queryImageLab);

gridSize = 25; % GRID SIZE
numRows = size(queryImageLab, 1) / gridSize;
numCols = size(queryImageLab, 2) / gridSize;

for i = 1:numRows
    for j = 1:numCols
        
        % Grid region
        replaceRegionRows = (i-1)*gridSize+1 : i*gridSize;
        replaceRegionCols = (j-1)*gridSize+1 : j*gridSize;
        
        % LAB in current grid region
        L_Region = queryImageLab(replaceRegionRows, replaceRegionCols, 1);
        A_Region = queryImageLab(replaceRegionRows, replaceRegionCols, 2);
        B_Region = queryImageLab(replaceRegionRows, replaceRegionCols, 3);
        
        currentColor = [mean(L_Region(:)),  mean(A_Region(:)), mean(B_Region(:))];

        currentDiff = inf;
        bestMatchIndex = 1; 
        
        % Calculate Euclidean distance for each image
        for q = 1:sizeDatabase
            
            targetColor = targetColors(q, :);
            
            delta = sqrt((currentColor(1) - targetColor(1)).^2 + (currentColor(2) - targetColor(2)).^2 + (currentColor(3) - targetColor(3)).^2);
            distance = mean(delta);

            if distance < currentDiff
                bestMatchIndex = q;
                currentDiff = distance;
            end   
        end

        % Resize image based on region size and place the small image by LAB channels 
        Pixel_Image = imresize(colorBase{bestMatchIndex}.L, [numel(replaceRegionRows), numel(replaceRegionCols)]);
        queryImageLab(replaceRegionRows, replaceRegionCols, 1) = Pixel_Image;
        
        Pixel_Image = imresize(colorBase{bestMatchIndex}.A, [numel(replaceRegionRows), numel(replaceRegionCols)]);
        queryImageLab(replaceRegionRows, replaceRegionCols, 2) = Pixel_Image;
        
        Pixel_Image = imresize(colorBase{bestMatchIndex}.B, [numel(replaceRegionRows), numel(replaceRegionCols)]);
        queryImageLab(replaceRegionRows, replaceRegionCols, 3) = Pixel_Image;


    end
end

rgbImage = lab2rgb(queryImageLab); 

end



