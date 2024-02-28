function [] = OptimizeDatabase_OnQueryImage(QueryImage, Turn_On)

if Turn_On == true
    
        disp('Optimizing database: option two'); 
    
        %-------------------------- DISP DOMINATING RGB ----------------------------
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
        
        %----------------------------- INDEXED RGB ---------------------------------

        [IND, map] = rgb2ind(QueryImage, 6);
        RGB = ind2rgb(IND, map);
        LAB = rgb2lab(RGB);

        %----------------------------- PLOT COLORS ---------------------------------
        figure;

        subplot(1, 3, 1);
        imshow(QueryImage);
        axis off; 
        title('Original RGB Image');

        subplot(1, 3, 2);
        imagesc(IND);
        colormap(map);
        title('Indexed with 6 colors');
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

        subplot(1, 6, 1);
        color_square(:, :, :) = ind2rgb(1, map); 
        imshow(color_square);

        subplot(1, 6, 2);
        color_square(:, :, :) = ind2rgb(2, map); 
        imshow(color_square);

        subplot(1, 6, 3);
        color_square(:, :, :) = ind2rgb(3, map); 
        imshow(color_square);
        
        subplot(1, 6, 4);
        color_square(:, :, :) = ind2rgb(4, map); 
        imshow(color_square);
        
        subplot(1, 6, 5);
        color_square(:, :, :) = ind2rgb(5, map); 
        imshow(color_square);
        
        subplot(1, 6, 6);
        color_square(:, :, :) = ind2rgb(6, map); 
        imshow(color_square);
        
        %----------------------------- OPTIMIZATION ---------------------------------

        % Modify the database according to the dominat colors in CIELAB

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
        
        dominatingFour = ind2rgb(4, map); 
        dominatingFour = rgb2lab(dominatingFour); 
        dominatingFourL = dominatingFour(:,:,1); 
        dominatingFourA = dominatingFour(:,:,2); 
        dominatingFourB = dominatingFour(:,:,3); 
        
        dominatingFive = ind2rgb(5, map); 
        dominatingFive = rgb2lab(dominatingFive); 
        dominatingFiveL = dominatingFive(:,:,1); 
        dominatingFiveA = dominatingFive(:,:,2); 
        dominatingFiveB = dominatingFive(:,:,3); 
        
        dominatingSix = ind2rgb(6, map); 
        dominatingSix = rgb2lab(dominatingSix); 
        dominatingSixL = dominatingSix(:,:,1); 
        dominatingSixA = dominatingSix(:,:,2); 
        dominatingSixB = dominatingSix(:,:,3); 


        counter = 0; 
        colorBaseNew = cell(200, 1);

        % Temporary database
        for i = 1:200 
            colorBaseNew{i} = struct('L', zeros(size(dataBase{1}, 1), size(dataBase{1}, 2)), ...
                                  'A', zeros(size(dataBase{1}, 1), size(dataBase{1}, 2)), ...
                                  'B', zeros(size(dataBase{1}, 1), size(dataBase{1}, 2)));
        end

        % Only add images from the database that is close enoguh to the dominating colors (Caluclated with euclidian distance).
        for i = 1:200

            foundSimilar = false;

            deltaOne = sqrt((colorBase{i}.L(:) - dominatingOneL(:)).^2 + ((colorBase{i}.A(:) - dominatingOneA(:)).^2 + ((colorBase{i}.B(:) - dominatingOneB(:)).^2))); 
            deltaTwo = sqrt((colorBase{i}.L(:) - dominatingTwoL(:)).^2 + ((colorBase{i}.A(:) - dominatingTwoA(:)).^2 + ((colorBase{i}.B(:) - dominatingTwoB(:)).^2)));
            deltaThree = sqrt((colorBase{i}.L(:) - dominatingThreeL(:)).^2 + ((colorBase{i}.A(:) - dominatingThreeA(:)).^2 + ((colorBase{i}.B(:) - dominatingThreeB(:)).^2)));

            deltaFour = sqrt((colorBase{i}.L(:) - dominatingFourL(:)).^2 + ((colorBase{i}.A(:) - dominatingFourA(:)).^2 + ((colorBase{i}.B(:) - dominatingFourB(:)).^2))); 
            deltaFive = sqrt((colorBase{i}.L(:) - dominatingFiveL(:)).^2 + ((colorBase{i}.A(:) - dominatingFiveA(:)).^2 + ((colorBase{i}.B(:) - dominatingFiveB(:)).^2)));
            deltaSix = sqrt((colorBase{i}.L(:) - dominatingSixL(:)).^2 + ((colorBase{i}.A(:) - dominatingSixA(:)).^2 + ((colorBase{i}.B(:) - dominatingSixB(:)).^2)));
            
            mean_delta_one = mean(mean(deltaOne));
            mean_delta_two = mean(mean(deltaTwo));
            mean_delta_three = mean(mean(deltaThree));
            
            mean_delta_four = mean(mean(deltaFour));
            mean_delta_five = mean(mean(deltaFive));
            mean_delta_six = mean(mean(deltaSix));
            
            treshold = 30; 

            
            if (mean_delta_one < treshold) || (mean_delta_two < treshold) || (mean_delta_three < treshold)        
                foundSimilar = true;        
            end 
            
            if (mean_delta_four < treshold) || (mean_delta_five < treshold) || (mean_delta_six < treshold)        
                foundSimilar = true;        
            end 

            if foundSimilar == true

                colorBaseNew{i}.L = colorBase{i}.L;
                colorBaseNew{i}.A = colorBase{i}.A;
                colorBaseNew{i}.B = colorBase{i}.B;

                counter = counter + 1; 

            end 

        end 
        
        %-------------------------- REMOVE PLACEHOLDERS -----------------------------

        numImages = numel(colorBaseNew);
        imagesToRemove = [];

        % Remove placeholders that were not occupied.
        for i = 1:numImages

            isBlack = all(colorBaseNew{i}.L(:) == 0) && all(colorBaseNew{i}.A(:) == 0) && all(colorBaseNew{i}.B(:) == 0);

            if isBlack
                imagesToRemove = [imagesToRemove, i];
            end
        end

        colorBaseNew(imagesToRemove) = [];

        % Write over the old database
        colorBase = colorBaseNew; 

        save colorBase colorBase;

        fprintf('Size of dataset after optimization with regard to query image: %d\n', numel(colorBase));

end
end