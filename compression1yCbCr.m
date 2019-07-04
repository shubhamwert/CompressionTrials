clc; close all; clear;
pkg load image
pkg load signal
pkg load communications

function CompressedImg = CompressImage(ImageOriginal)


ImageSize=8*prod(size(ImageOriginal));
imshow(ImageOriginal);
fprintf('\nsize of original image is %d\n',ImageSize);

Y = ImageOriginal;
I=ImageOriginal;

Y = rgb2ycbcr(I);
size(Y)

%downsampling images

subplot(1,2,1)
imshow( I )
title('Original')
subplot(1,2,2)
Y_d = Y;
Y_d(:,:,2) = 3*round(Y_d(:,:,2)/3);
Y_d(:,:,3) = 3*round(Y_d(:,:,3)/3);
imshow(ycbcr2rgb(Y_d))
title('Downsampled image')

fprintf('\ncosine Transforamtion\n')
%cosine transforamtion
clf
boxs = Y_d;
II = boxs(100:107,100:107,1);
Y = dct(dct(II).').';

surf(log10(abs(Y))), title('DCT coefficients')
set(gca,'fontsize',16)

fprintf('\napplying quatizing matrix\n')

P=zeros(size(Y_d));
R=P;

Q = [16 11 10 16 24 40 51 61 ;
     12 12 14 19 26 28 60 55 ;
     14 13 16 24 40 57 69 56 ;
     14 17 22 29 51 87 80 62 ;
     18 22 37 56 68 109 103 77 ;
     24 35 55 64 81 104 113 92 ;
     49 64 78 87 103 121 120 101;
     72 92 95 98 112 100 103 99];
fprintf("\n\ncalcualting")
Y = Q.*round(Y./Q);

for i=1:3
    for j=1:8:size(Y_d,1)-7
   
        for k = 1:8:size(Y_d,2)-7
            fprintf(".");
            II = Y_d(j:j+7,k:k+7,i);
            freq = dct(dct(II).').';
            freq = Q.*round(freq./Q);
            P(j:j+7,k:k+7,i) = freq;
            R(j:j+7,k:k+7,i) = idct(idct(freq).').';
            if rem(k/8,4)==0
            fprintf("\b\b\b\b")
            end
        
        end
        fprintf("\ncalculating for j == ",j);
    end
end

fprintf("\nplotting results for step 1\n")
subplot(1,2,1)
imshow(ImageOriginal)
title('Original')
subplot(1,2,2)
step1save=ycbcr2rgb(uint8(R));
imshow(step1save);
title('Compressed')
pause;
fprintf("\nstep 1 compression result\n");
CompressedImageSize = 8*nnz(P(:,:,1)) + 7*nnz(P(:,:,2)) + 7*nnz(P(:,:,3))
CompressedImageSize/ImageSize
imwrite(step1save,"step1save.jpg")


%Huffman coding

fprintf("Huffman Coding>>")
b = P(:); b = b(:); b(b==0)=[];  
 b = floor(255*(b-min(b))/(max(b)-min(b))); 
 symbols = unique(b); 
 prob = histc(b,length(symbols))/length(b); 
 dict = huffmandict(symbols, prob);
  enco = huffmanenco(b, dict); 
 FinalCompressedImage = length(enco); 
FinalCompressedImage/ImageSize 

subplot(1,2,1)
imshow(I)
title('Original')
subplot(1,2,2)
imshow(ycbcr2rgb(uint8(B)));
title('Compressed')

end

ImageOriginal=imread('bird_small.png');
ImageOriginal2=imread('SamplePNGImage_10mbmb.png');
fprintf('\nimage 1 loaded successfully\n');
CompressImage(ImageOriginal2);
CompressImage(ImageOriginal);
