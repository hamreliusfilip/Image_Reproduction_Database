resizedImages = cell(1, 18);

% Assuming you want 3 rows and 6 columns for the final image
numRows = 3;
numCols = 6;

% Specify the target size for resizing
targetSize = [1000, 1000];  % Adjust the size as needed

for i = 1:18
    if (i < 10)
        filePath = fullfile('Images', sprintf('db1_0%d.jpg', i));
    else
        filePath = fullfile('Images', sprintf('db1_%d.jpg', i));
    end

    currentImage = imread(filePath);

    resizedImage = imresize(currentImage, targetSize);
    
    resizedImages{i} = resizedImage;
end

% Ensure the number of images is equal to numRows * numCols
numImages = numRows * numCols;
resizedImages = resizedImages(1:numImages);

% Pad the images to ensure they have the same dimensions
paddedImages = cellfun(@(x) padarray(x, [size(resizedImages{1}, 1) - size(x, 1), size(resizedImages{1}, 2) - size(x, 2)], 0, 'post'), resizedImages, 'UniformOutput', false);

% Reshape the cell array into a 3D array with numRows rows and numCols columns
reshapedImages = reshape(paddedImages, numRows, numCols);

% Concatenate along rows and columns to form the final image
finalImage = cat(1, cat(2, reshapedImages{:, 1}), cat(2, reshapedImages{:, 2}), cat(2, reshapedImages{:, 3}), ...
                  cat(2, reshapedImages{:, 4}), cat(2, reshapedImages{:, 5}), cat(2, reshapedImages{:, 6}));

% Display the final image
imshow(finalImage);
