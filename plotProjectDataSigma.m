function  plotProjectDataSigma(pcNumber, data, meanProjection, coeff, score, reshapeSize)
    dotProduct = 0;
    figure();
    imgIdx = 300;

    dotProduct =  score(imgIdx,pcNumber) * coeff(:,pcNumber)';


    sigmaRange = [-3 -2 -1 0 1 2 3];
    lenSigma = length(sigmaRange);
    [~, ~, sigma] = zscore(data);

    for i = 1: lenSigma
        reconstructedImage = meanProjection + dotProduct + sigmaRange(i) * sigma;
        img = reshape(reconstructedImage, reshapeSize);
        subplottight(1, lenSigma, i);
        imshow(img,[],'border', 'tight');
    end

end

