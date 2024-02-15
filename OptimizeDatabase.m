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
    counter = 0; 
    treshold = 8000; 
    
    if TurnOnOpt == true
        for j = 1:200 
       
            if any(abs(colorBase{j}.L(:) - L(:)) < treshold) || ...
               any(abs(colorBase{j}.A(:) - A(:)) < treshold) || ...
               any(abs(colorBase{j}.B(:) - B(:)) < treshold)

                foundSimilar = true;
                break; 
            end 
        end 
    end
    
    if TurnOnOpt == false || ~foundSimilar || counter < 100
        colorBase{i} = struct('L', L, 'A', A, 'B', B);
        counter = counter + 1; 
    end 
end 
    
save colorBase colorBase

end 
