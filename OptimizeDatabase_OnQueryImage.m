function [] = OptimizeDatabase_OnQueryImage(QueryImage)

    hsvImage = rgb2hsv(QueryImage);

    histogramValues = imhist(hsvImage(:,:,1), 700);

    xRange = 400:700;
    histogramValuesSubset = histogramValues(xRange);

    [peaks, locations] = findpeaks(histogramValuesSubset);

    [sortedPeaks, sortedIndices] = sort(peaks, 'descend');
    
    sortedPeaks

    figure;
    bar(xRange, histogramValuesSubset);
    hold on;
    scatter(xRange(locations(sortedIndices(1:5))), sortedPeaks(1:5), 'r', 'filled');
    hold off;

    title('Top 5 Dominating Colors (400-700 Hue Range)');
    xlabel('Hue Value');
    ylabel('Frequency');

    legend('Histogram', 'Top 5 Dominating Colors');


end 


