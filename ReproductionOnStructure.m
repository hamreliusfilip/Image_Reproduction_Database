function [rgbImage] = ReproductionOnStructure(queryImageLab,QueyImageRGB)

load colorBase.mat colorBase
load dataBase.mat dataBase

disp('Calculating reproduction image on structure...');

sizeDatabase = numel(colorBase); 

% ----------------- Colors in LAB for all the regions ------------------

targetColors = zeros(200, 3);

for q = 1:sizeDatabase
    targetColors(q, 1) = mean(colorBase{q}.L(:));
    targetColors(q, 2) = mean(colorBase{q}.A(:));
    targetColors(q, 3) = mean(colorBase{q}.B(:));
end

queryImageLab = im2double(queryImageLab);

gridSize = 25; 
numRows = size(queryImageLab, 1) / gridSize;
numCols = size(queryImageLab, 2) / gridSize;

% -------------- Find the images matching best for colors --------------

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

        bestMatchIndices = [];
        counter = 1;

        % Calculate Euclidean distance for each image
        for q = 1:200
            targetColor = targetColors(q, :);

            delta = sqrt((currentColor(1) - targetColor(1)).^2 + (currentColor(2) - targetColor(2)).^2 + (currentColor(3) - targetColor(3)).^2);
            distance = mean(delta);

            if distance < 20
                bestMatchIndices{counter} = q;
                counter = counter + 1; 
            end   
            
        end
        
        % Retrieve the corresponding elements from dataBase
        bestMatches = []; 
        
        for v = 1:length(bestMatchIndices)
  
            bestMatches{v} = dataBase{bestMatchIndices{v}};
            
        end

% -------------------- Decide on structure --------------------
        
        bestMatchesGray = [];
        
        for u = 1:length(bestMatches) 
            
            bestMatchesGray{u} = rgb2gray(bestMatches{u});
            
        end 
        
        finalReplacement = imread("Test_Images/Skriet.jpg"); % Placeholder img 
        currentMatchDistance = -1; % Worse result SSIM can generate
        
        queryRegionGray = im2gray(QueyImageRGB(replaceRegionRows, replaceRegionCols));
        queryRegionGray = im2double(queryRegionGray);

        for k = 1:length(bestMatchesGray) 
            
            currentMatch = im2double(bestMatchesGray{k}); 
            currentMatchRGB = im2double(bestMatches{k}); 
            ssimval = ssim(currentMatch, queryRegionGray);

            if currentMatchDistance < ssimval
                finalReplacement = currentMatchRGB;
                currentMatchDistance = ssimval;
            end 
        end 

        finalReplacementLAB = rgb2lab(finalReplacement);
        
        finalReplacementL = finalReplacementLAB(:,:,1); 
        finalReplacementA = finalReplacementLAB(:,:,2); 
        finalReplacementB = finalReplacementLAB(:,:,3); 
         
        Pixel_Image = imresize(finalReplacementL, [numel(replaceRegionRows), numel(replaceRegionCols)]);
        queryImageLab(replaceRegionRows, replaceRegionCols, 1) = Pixel_Image;
        
        Pixel_Image = imresize(finalReplacementA, [numel(replaceRegionRows), numel(replaceRegionCols)]);
        queryImageLab(replaceRegionRows, replaceRegionCols, 2) = Pixel_Image;
        
        Pixel_Image = imresize(finalReplacementB, [numel(replaceRegionRows), numel(replaceRegionCols)]);
        queryImageLab(replaceRegionRows, replaceRegionCols, 3) = Pixel_Image;
        
    end
end

rgbImage = lab2rgb(queryImageLab); 

end



