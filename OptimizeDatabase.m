function [] = OptimizeDatabase(TurnOnOpt, treshold, amountOfImages)

load dataBase.mat dataBase

if TurnOnOpt == true
    disp('Optimizing database: option one'); 
end

counter = 1; 
colorBase = cell(amountOfImages, 1);

for i = 1:amountOfImages
    colorBase{i} = struct('L', zeros(size(dataBase{1}, 1), size(dataBase{1}, 2)), ...
                          'A', zeros(size(dataBase{1}, 1), size(dataBase{1}, 2)), ...
                          'B', zeros(size(dataBase{1}, 1), size(dataBase{1}, 2)));
end

% Add the images that differentiate enough from other images in the database
for i = 1:amountOfImages
    
    currentImage = dataBase{i};
    
    labImage = rgb2lab(currentImage);
    
    L = labImage(:, :, 1);
    A = labImage(:, :, 2);
    B = labImage(:, :, 3);
    
    foundSimilar = false;
    
    if TurnOnOpt == true
        for j = 1:amountOfImages 
            
             delta = sqrt((colorBase{j}.L(:) - L(:)).^2 + ((colorBase{j}.A(:) - A(:)).^2 + ((colorBase{j}.B(:) - B(:)).^2))); 
             mean_delta = mean(mean(delta));
       
            if mean_delta < treshold

                foundSimilar = true;
                break; 
                
            end 
        end 
    end
    
    % If no similair and the option is turned on, add image
    if TurnOnOpt == true && foundSimilar == false
        if (counter <= amountOfImages) 
            colorBase{i} = struct('L', L, 'A', A, 'B', B);
            counter = counter + 1; 
        end 
    end 
    
    % If option is turned off, always add (normal database).
    if TurnOnOpt == false 
         colorBase{i} = struct('L', L, 'A', A, 'B', B);
    end 
end 

% Remove placeholders that were not occupied 
% (In case the treshold were tighter than allowed images.) 
numImages = numel(colorBase);
imagesToRemove = [];

for i = 1:numImages

    isBlack = all(colorBase{i}.L(:) == 0) && all(colorBase{i}.A(:) == 0) && all(colorBase{i}.B(:) == 0);

    if isBlack
        imagesToRemove = [imagesToRemove, i];
    end
end

colorBase(imagesToRemove) = [];

fprintf('Size of dataset: %d\n', numel(colorBase));

save colorBase colorBase;

end 
