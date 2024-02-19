function [] = OptimizeDatabase_OnQueryImage(QueryImage)

colors = 'RGB';
I = QueryImage;
[~,idx] = max(sum(sum(I,1),2),[],3);
dominant = colors(idx); 

if (dominant == 'R') 
    fprintf('Dominant color: %s - Optimizing database accordingly\n', 'Red');
elseif  (dominant == 'G')  
   fprintf('Dominant color: %s - Optimizing database accordingly\n', 'Green');
else 
    fprintf('Dominant color: %s - Optimizing database accordingly\n', 'Blue');
end 

% Indexed RGB 
[IND, map] = rgb2ind(QueryImage, 3);
RGB = ind2rgb(IND, map);
LAB = rgb2lab(RGB);

% Plot all the information
figure;

subplot(1, 3, 1);
imshow(QueryImage);
axis off; 
title('Original RGB Image');

subplot(1, 3, 2);
imagesc(IND);
colormap(map);
title('Indexed with 3 colors');
axis off; 
axis square; 

subplot(1, 3, 3);
imagesc(LAB);
title('CIELAB representation');
axis off;
axis square; 

hold off; 

figure; 

color_square = zeros(1, 1, 3); 

subplot(1, 3, 1);
color_square(:, :, :) = ind2rgb(1, map); 
imshow(color_square);
title('Dominant Color 1');

subplot(1, 3, 2);
color_square(:, :, :) = ind2rgb(2, map); 
imshow(color_square);
title('Dominant Color 2');

subplot(1, 3, 3);
color_square(:, :, :) = ind2rgb(3, map); 
imshow(color_square);
title('Dominant Color 3');

% Modify the database according to the dominat colors 

load colorBase.mat colorBase
load dataBase.mat dataBase

dominatingOne = ind2rgb(1, map); 
dominatingOne = rgb2lab(dominatingOne); 
dominatingOneL = dominatingOne(:,:,1); 
dominatingOneA = dominatingOne(:,:,2); 
dominatingOneB = dominatingOne(:,:,3); 

dominatingTwo = ind2rgb(2, map); 
dominatingTwo = rgb2lab(dominatingTwo); 
dominatingTwoL = dominatingTwo(:,:,1); 
dominatingTwoA = dominatingTwo(:,:,2); 
dominatingTwoB = dominatingTwo(:,:,3); 

dominatingThree = ind2rgb(3, map); 
dominatingThree = rgb2lab(dominatingThree); 
dominatingThreeL = dominatingThree(:,:,1); 
dominatingThreeA = dominatingThree(:,:,2); 
dominatingThreeB = dominatingThree(:,:,3); 

counter = 0; 
colorBaseNew = cell(200, 1);

for i = 1:200
    colorBaseNew{i} = struct('L', zeros(size(dataBase{1}, 1), size(dataBase{1}, 2)), ...
                          'A', zeros(size(dataBase{1}, 1), size(dataBase{1}, 2)), ...
                          'B', zeros(size(dataBase{1}, 1), size(dataBase{1}, 2)));
end

for i = 1:200
    
    foundSimilar = false;
          
    deltaOne = sqrt((colorBase{i}.L(:) - dominatingOneL(:)).^2 + ((colorBase{i}.A(:) - dominatingOneA(:)).^2 + ((colorBase{i}.B(:) - dominatingOneB(:)).^2))); 
    deltaTwo = sqrt((colorBase{i}.L(:) - dominatingTwoL(:)).^2 + ((colorBase{i}.A(:) - dominatingTwoA(:)).^2 + ((colorBase{i}.B(:) - dominatingTwoB(:)).^2)));
    deltaThree = sqrt((colorBase{i}.L(:) - dominatingThreeL(:)).^2 + ((colorBase{i}.A(:) - dominatingThreeA(:)).^2 + ((colorBase{i}.B(:) - dominatingThreeB(:)).^2)));
               
    mean_delta_one = mean(mean(deltaOne));
    mean_delta_two = mean(mean(deltaTwo));
    mean_delta_three = mean(mean(deltaThree));
       
    if (mean_delta_one < 30) || (mean_delta_two < 30) || (mean_delta_three < 30)        
        foundSimilar = true;        
    end 
    
    if foundSimilar == true

        colorBaseNew{i}.L = colorBase{i}.L;
        colorBaseNew{i}.A = colorBase{i}.A;
        colorBaseNew{i}.B = colorBase{i}.B;
        
        counter = counter + 1; 
        
    end 
    
end 

numImages = numel(colorBaseNew);
imagesToRemove = [];

for i = 1:numImages

    isBlack = all(colorBaseNew{i}.L(:) == 0) && all(colorBaseNew{i}.A(:) == 0) && all(colorBaseNew{i}.B(:) == 0);

    if isBlack
        imagesToRemove = [imagesToRemove, i];
    end
end

colorBaseNew(imagesToRemove) = [];

colorBase = colorBaseNew; 

save colorBase colorBase;

fprintf('Size of dataset after optimization with regard to query image: %d\n', numel(colorBase));

end
