function [rgbImage] = Reproduction(queryImageLab)

load colorBase.mat colorBase

queryImageLab = im2double(queryImageLab);

gridSize = 25; 
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
        
        % Use median instead of mean
        currentColor = [median(L_Region(:)), median(A_Region(:)), median(B_Region(:))];

        % Varibles
        currentDiff = inf;
        bestMatchIndex = 1; 
        
        % Calculate Euclidean distance for each image
        for q = 1:200
            
            targetColor = [median(colorBase{q}.L(:)), median(colorBase{q}.a(:)), median(colorBase{q}.b(:))];
            
            distance = norm(currentColor - targetColor);

            if distance < currentDiff
                bestMatchIndex = q;
                currentDiff = distance;
            end   
        end

        % Resize image based on region size and place the small image. 
        Pixel_Image = imresize(colorBase{bestMatchIndex}.L, [numel(replaceRegionRows), numel(replaceRegionCols)]);
        queryImageLab(replaceRegionRows, replaceRegionCols, 1) = Pixel_Image;
        
        Pixel_Image = imresize(colorBase{bestMatchIndex}.a, [numel(replaceRegionRows), numel(replaceRegionCols)]);
        queryImageLab(replaceRegionRows, replaceRegionCols, 2) = Pixel_Image;
        
        Pixel_Image = imresize(colorBase{bestMatchIndex}.b, [numel(replaceRegionRows), numel(replaceRegionCols)]);
        queryImageLab(replaceRegionRows, replaceRegionCols, 3) = Pixel_Image;


    end
end

rgbImage = lab2rgb(queryImageLab); 

end



