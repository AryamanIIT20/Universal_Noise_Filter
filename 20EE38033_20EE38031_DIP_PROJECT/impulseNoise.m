function [img_noisy] = impulseNoise(img,p) % Adds random impulse noise of probability p to image
[M,N] = size(img);
img_noisy = img;
for i = 1:M
    for j = 1:N
        k = rand;
        q = rand;
        if k<p
            img_noisy(i,j) = uint8(255*q);
        end
    end
end
end

