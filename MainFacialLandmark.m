clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.

%%%%%%%%%%%%%%%% Load Images from CKDB folder %%%%%%%%%%%%
[~, shapeData] = LoadImages('CKDB');


% ======= Plot 150 orignal dataset =======
figure();
for ii = 1:150
   subplottight(10,15,ii);
   plotFacialLandmarks(squeeze(shapeData(ii,:,:)), "");
end
title("Dataset");

% Apply PCA to Facial Landmark
nComponents = 100;
fLandmarks = extractFeaturesFromData(shapeData, 'landmark');
[coeff,score,latent,~,explained, mean] = pca(fLandmarks, ...
            'NumComponents', nComponents, ...
            'Centered', true, ...
            'VariableWeights', 'variance');


% ======= Plot eigen-facial landmark =======
% figure();
% landmarkSize = [68 2];
% for ii = 1:nComponents
%    subplottight(10,15,ii);
%    plotFacialLandmarks(reshape(coeff(:, ii), landmarkSize), "");
% end
% title("");
% ======= Eigenvalue Graph ========
figure();
hold on;
cs = cumsum(explained); % to specify range --> explained(1:40, :)
plot(cs)
xlabel('Dimension');
ylabel('Eigenvalue');
title("Cumulative Variance Explained")
hold off;

figure();
hold on;
pareto(explained);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
title("Scree Plot");
hold off;


[~, ~, sigma] = zscore(fLandmarks);
sigmaRange = [-3 -2 -1 0 1 2 3];
lenSigma = length(sigmaRange);

% ======= Plot landmark in range of sigma based on max variance basis
pcNumber = 1;
landmarkSize = [68 2];
nCol = 5;
figure();
for i=1:lenSigma
    subplottight(1,7,i);
    reconstruction = mean + score(1, pcNumber) * coeff(:,pcNumber).' + sigma * sigmaRange(i);
    p = plotFacialLandmarks(reshape(reconstruction,landmarkSize), "");
end
title("Variance");

