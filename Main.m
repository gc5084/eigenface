clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables. Or clear vars.
workspace;  % Make sure the workspace panel is showing.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Main File to run eigenfaces for images  %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 
%%%%%%%%%%%%%%%% Load Images from CKDB folder %%%%%%%%%%%%
[imagesData shapeData] = LoadImages('CKDB');

if 0
% ======= Plot 150 orignal images dataset =======
figure();
for ii = 1:150
   subplottight(10,15,ii);
   imshow(squeeze(imagesData(ii,:, :)), [],'border', 'tight');
end
title("Dataset");
end
%%%%%%%%%%%%%%%% Extract features  %%%%%%%%%%%%
% Extract features, feature here is grayscale
grayscaleImages = extractFeaturesFromData(imagesData, 'grayscale');


%%%%%%%%%%%%%%%% Analzye Eigenfaces and what they try to capture  %%%%%%%%%%%%
% Here we use pca function. Below are explantions which excerpt from
% matworks webiste.

% coeff:    Principal component coefficients, returned as a p-by-p matrix. 
%           Each column of coeff contains coefficients for one principal component. 
%           The columns are in the order of descending component variance, latent.
% score:    Principal component scores, returned as a matrix. 
%           Rows of score correspond to observations, and columns to components.
% latent:   Principal component variances, that is the eigenvalues of 
%           the covariance matrix of X, returned as a column vector.
% tsquared: Hotelling’s T-Squared Statistic, which is the sum of squares 
%           of the standardized scores for each observation, returned as a column vector.
% explained: Percentage of the total variance explained 
%           by each principal component, returned as a column vector.
%           Estimated means of the variables in X, 
%           returned as a row vector when Centered is set to true. 
%           When Centered is false, the software does not compute the means 
%           and returns a vector of zeros.

% Set number of components to retain
nComponents = 10;


% ===== How to set parameter for pca() =====

% Default. pca centers X by subtracting column means 
% before computing singular value decomposition or eigenvalue decomposition. 
% If X contains NaN missing values, 
% nanmean is used to find the mean with any available data. 
% You can reconstruct the centered data using score*coeff'.

% VariableWeights
% If 'Centered' is set to true at the same time, 
% the data matrix X is centered and standardized. 
% In this case, pca returns the principal components 
% based on the correlation matrix.
[coeff,score,~,~,explained, mu] = pca(grayscaleImages, ...
            'NumComponents', nComponents, ...
            'Centered', true, ...
            'VariableWeights', 'variance');


% ======= Visualize Eigenvalues of Eigenfaces Graph ========
figure();
hold on;
cs = cumsum(explained); % to specify range --> explained(1:40, :)
xlabel('Dimension');
ylabel('Eigenvalue');
title("Cumulative Variance Explained")
plot(cs)
hold off;

figure();
hold on;
xlabel('Principal Component');
ylabel('Variance Explained (%)');
pareto(explained);
title("Scree Plot");
hold off;


% for mapping of grayscale image when using imshow
color_map_grey = [];

% ===== Plot eigenfaces ====
nCol = 15;
figure();
for ii = 1:nComponents
   subplottight((nComponents)/nCol,nCol,ii);
   img = reshape(coeff(:,ii), [128,128]); 
   imshow(squeeze(img), [],'border', 'tight');
end
title("Eigenfaces");
% 
% % ===== Plot mean eigenface ====
figure();
imshow(reshape(mu, [128,128]), color_map_grey);
title("Mean (common features)");

% ======= Plot Progressional of having more eigenfaces =====
pcNumber = 1; % max variance
plotProjectDataSigma(pcNumber, grayscaleImages, mu, coeff, score, [128,128]);

    
% ===== Reconstruct the images and plot orignial vs reconstructed ====
figure();
nCol = 10;
nSubplot = 1;
reconstructedImages = mu + score * coeff.';
for ii = 1:10
   
   subplottight((nComponents)/nCol,nCol,nSubplot);
   imgOri = reshape(imagesData(ii, :), [128,128]);
   imshow(imgOri, [],'border', 'tight');
   
   nSubplot = nSubplot + 1;
   subplottight((nComponents)/nCol,nCol,nSubplot);
   img = reshape(reconstructedImages(ii, :), [128,128]);
   imshow(img,[],'border', 'tight');
   
   nSubplot = nSubplot + 1;
end
title("Comparison between origal images and reconstructed images with selected N principal components");

% ===========================
% ===== Start eigen-lips ====
% ===========================
lips = extractFeaturesFromData(imagesData, 'lips');
% DO pca lips
nComponents = 100;
[coeffLips,scoreLips,~,~,explainedLips, meanLips] = pca(lips,...
            'NumComponents', nComponents, ...
            'Centered', true, ...
            'VariableWeights', 'variance'); 

lipsHeightWidthImg = [35,60];

% ===== Plot mean eigen lips ====
figure();
imshow(reshape(meanLips, lipsHeightWidthImg), color_map_grey);
title("Mean Mouth");

% ===== Plot eigen-mouth ====
nCol = 15;
figure();
for ii = 1:nComponents
   subplottight((nComponents)/nCol,nCol,ii);
   img = reshape(coeffLips(:,ii), lipsHeightWidthImg); 
   imshow(squeeze(img), [],'border', 'tight');
end
title("Eigen-mouths");

% ======= Plot based on different sigma =====
pcNumber = 1; % max variance
plotProjectDataSigma(pcNumber, lips, meanLips, coeffLips, scoreLips, lipsHeightWidthImg);
title("Mouth variance");

% ===========================
% ===== Start Eigen-eyes =====
% ===========================
eyes = extractFeaturesFromData(imagesData, 'eyes');

nComponents = 10;
[coeffEyes, scoreEyes,~,~,explainedEyes, meanEyes] = ...
    pca(eyes, 'NumComponents', nComponents, ...
            'Centered', true, ...
            'VariableWeights', 'variance'); 

croppedHeightWidthImg = [35,110];
% ===== Plot mean eigen eyes ====
figure();
imshow(reshape(meanEyes, croppedHeightWidthImg), color_map_grey);
title("Mean Eyes");


% ===== Plot eigen-eyes ====
nCol = 10;
figure();
for ii = 1:nComponents
   subplottight((nComponents)/nCol,nCol,ii);
   img = reshape(coeffEyes(:,ii), croppedHeightWidthImg); 
   imshow(squeeze(img), [],'border', 'tight');
end
title("Eigen-eyes");

% ======= Plot Progressional of having more eigenfaces =====
pcNumber = 1; % max variance
plotProjectDataSigma(pcNumber, eyes, meanEyes, coeffEyes, scoreEyes, croppedHeightWidthImg);
title("Eyes variance");



