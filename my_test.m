function [] = my_test()
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
% x_size = 32;
% y_size = 32;
% 
% img_count = 20;
% imagesData = zeros(img_count,x_size,y_size);
% X = [];
% for i=1:img_count
%     pathFile = sprintf('CKDB/0/%d_0.tiff',i);
%     img = imread(pathFile);
%     resize_img = imresize(img,[x_size,y_size]);
%     imagesData(i,:,:) = resize_img';
%     temp = reshape(resize_img',x_size*y_size,1);
%     X = [X temp];
% end
% re_imgs_data = reshape(imagesData,size(imagesData,1),x_size*y_size);
% 
% nComponents = 10;

X = [1,2,3;4,5,6];
X = X';
%[coeff,score,~,~,explained, mu] = pca(re_imgs_data,'NumComponents', nComponents);
[coeff,score,~,~,explained, mu] = pca(X');
if(1) %test eig
img_m = mean(X,2);
imgcount = size(X,2);
A = [];
for i=1 : imgcount
    temp = double(X(:,i)) - img_m;
    A = [A temp];
end
L= A'*A;
[V,D]=eig(L);  %% V : eigenvector matrix  D : eigenvalue matrix
%to find how many Principal Components (eigenvectors) to be taken
% L_eig_vec = [];
% for i = 1 : size(V,2) 
%     if( D(i,i) > 1 )
%         L_eig_vec = [L_eig_vec V(:,i)];
%     end
% end

eigenfaces = A * V;



end





% ===== Plot mean face ====   
figure();
imshow(reshape(mu, [x_size,y_size])', []);
% ===== Plot eigenfaces ====
nCol = 10;
figure();
for ii = 1:nComponents
   subplot(1,nCol,ii);
   img = reshape(coeff(:,ii), [x_size,y_size]); 
   imshow(squeeze(img)', [],'border', 'tight');
end

disp('break point');




end

