clc; close all; clear;
ImageOriginal=imread('bird_small.png');

fprintf('\nimage loaded successfully\n');

imshow(ImageOriginal);
fprintf('\nsize of original image is %d\n',8*prod(size(ImageOriginal)));

Y = ImageOriginal;
I=ImageOriginal;

Y = rgb2ycbcr(I);
%downsampling images

subplot(1,2,1)
imshow( I )
title('Original')
subplot(1,2,2)
Y_d = Y;
Y_d(:,:,1) = 10*round(Y_d(:,:,1)/10);
Y_d(:,:,2) = 30*round(Y_d(:,:,2)/30);
Y_d(:,:,3) = 30*round(Y_d(:,:,3)/30);
imshow(ycbcr2rgb(Y_d))
title('Downsampled image')

fprintf('cosine Transforamtion')
%cosine transforamtion
Y_d=dct(Y_d);
%signal comparison
fprintf('signal comparison')

x=Y;
X = Y_d;
[XX,ind] = sort(abs(X),'descend');
i = 1;
while norm(X(ind(1:i)))/norm(X) < 0.99
   i = i + 1;
end
needed = i;
X(ind(needed+1:end)) = 0;
xx = idct(X);

plot([x;xx]')
legend('Original',['Reconstructed, N = ' int2str(needed)], ...
       'Location','SouthEast')
pause;