clc;
clear;

% noise parameters
p = 0.05; % probability of impulse noise
stdev = 10; % gaussian noise standard deviation [0, 255]
stdev = stdev/255; % normalized standard deviation [0, 1]

% filter parameters
nbd = 2; % neighbourhood size : (2*nbd + 1)X(2*nbd + 1)
s_s = 0.5;
s_i = 25;
s_j = 30;

img_orig = imread("lena.tif");
[M,N] = size(img_orig);
img_noisy = imnoise(img_orig,"salt & pepper",p);
img_noisy = gaussian_noise(img_noisy,stdev);

tgt = UNF_filter(img_noisy,nbd,s_s,s_i,s_j);
s_s = 4;
tgt = UNF_filter(tgt,nbd,s_s,s_i,s_j);
median_filtered = my_median_filter(img_noisy,1);

PSNR_noisy = 10*log10(255*255*M*N/sum((double(img_orig)-double(img_noisy)).^2,"all"));
PSNR_UNF  = 10*log10(255*255*M*N/sum((double(img_orig)-double(tgt)).^2,"all"));
PSNR_median = 10*log10(255*255*M*N/sum((double(img_orig)-double(median_filtered)).^2,"all"));

% subplot(2,2,1);
% imshow(img_orig);
% title("original");
% subplot(2,2,2);
% imshow(img_noisy);
% title("noisy");
% subplot(2,2,3);
% imshow(tgt);
% title(sprintf("UNF filtered PSNR = %0.2f",PSNR_UNF));
% subplot(2,2,4);
% imshow(median_filtered);
% title(sprintf("median filtered PSNR = %0.2f",PSNR_median));
% shg;


figure;
subplot(1,2,1);
imshow(tgt);
title(sprintf("UNF filtered PSNR = %0.2f",PSNR_UNF));
subplot(1,2,2);
imshow(median_filtered);
title(sprintf("median filtered PSNR = %0.2f",PSNR_median));
shg;





% original noisy and UNF
% figure;
% subplot(1,3,1);
% imshow(img_orig);
% title("original");
% subplot(1,3,2);
% imshow(img_noisy);
% title(sprintf("p = %0.2f %%",p*100));
% subplot(1,3,3);
% imshow(tgt);
% title(sprintf("UNF filtered PSNR = %0.2f",PSNR_UNF));
% shg;



