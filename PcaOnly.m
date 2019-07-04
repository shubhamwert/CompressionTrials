clear;close all;clc

X_original=imread('step1save.jpg');

fprintf("\nimage loaded successfully\n")
size(X_original)
pause
X_reshape=reshape(X_original,size(X_original)(1),3*size(X_original)(2));
size(X_reshape)
imshow(X_original);
pause;
fprintf("\nnormalizzing\n");
K=100;
X_norm=double(normalize(X_reshape));
size(X_reshape);
fprintf("\nApplying PCA\n");
[X_pca,S,D]=Pca(X_norm);
fprintf('\nPca Done');
fprintf("\nProjecting Data\n");

Z = projectData(X_norm, X_pca, K);
imshow(Z);
pause;
plot(Z);
pause;
fprintf("\nrecovering data\n");
X_rec=recover(Z,X_pca,K);
imshow(X_rec);
pause;
