function [img_noisy] = gaussian_noise(img,stdev) % Adds 0 mean, stdev standard deviation gaussian noise to image
img = double(img)/255;
img_noisy = img + stdev*randn(size(img));
img_noisy = uint8(255*img_noisy);
end

