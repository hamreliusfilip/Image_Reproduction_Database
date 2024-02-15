

%-------------- Choose what Image to re-create ----------------
queryImage = imread("Database_logos/32.jpg"); % Logos 
imshow(queryImage);

% Re-sizing image
queryImage = imresize(queryImage, [2000, 2000]);

% Change color space from RGB to CIELAB
queryImageLab = rgb2lab(queryImage);

QueryColorBase = cell(1, 1);

% CIELAB color values 
L_Query = sum(sum(queryImageLab(:,:,1))); 
A_Query = sum(sum(queryImageLab(:,:,2)));
B_Query = sum(sum(queryImageLab(:,:,3))); 
    
QueryColorBase{1} = struct('L', L_Query, 'a', A_Query, 'b', B_Query);
save QueryColorBase QueryColorBase

CreateDatabase();
imgFinal = Reproduction(queryImage);
imshow(imgFinal);





