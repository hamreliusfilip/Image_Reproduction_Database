function [] = OptimizeDatabase(TurnOnOpt)

%----------------------- Create color database ------------------------

load dataBase.mat dataBase

colorBase = cell(200, 1);

for i = 1:200
    colorBase{i} = struct('L', zeros(size(dataBase{1}, 1), size(dataBase{1}, 2)), ...
                          'A', zeros(size(dataBase{1}, 1), size(dataBase{1}, 2)), ...
                          'B', zeros(size(dataBase{1}, 1), size(dataBase{1}, 2)));
end

for i = 1:200
    
    currentImage = dataBase{i};
    
    labImage = rgb2lab(currentImage);
    
    L = labImage(:, :, 1);
    A = labImage(:, :, 2);
    B = labImage(:, :, 3);
    
    foundSimilar = false;
    
    if TurnOnOpt == true
        for j = 1:200 
            
             delta = sqrt((colorBase{j}.L(:) - L(:)).^2 + ((colorBase{j}.A(:) - A(:)).^2 + ((colorBase{j}.B(:) - B(:)).^2))); 
             mean_delta = mean(mean(delta));
       
            if mean_delta < 10

                foundSimilar = true;
                break; 
                
            end 
        end 
    end
    
    if TurnOnOpt == false || foundSimilar == false
        colorBase{i} = struct('L', L, 'A', A, 'B', B);
    end 
end 
    
save colorBase colorBase

end 
