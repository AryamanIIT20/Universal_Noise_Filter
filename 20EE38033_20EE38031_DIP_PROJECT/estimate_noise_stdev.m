function [stdev_estimate] = estimate_noise_stdev(img,nbd,s_i) % Estimate quasi-gaussian noise standard deviation 
[M,N] = size(img);
L = [1,-2,1;-2,4,-2;1,-2,1]; % Kernel of Laplacian Filter
img_lap = myconv2d(img,L);
img_padded = zeros(M+2*nbd,N+2*nbd);
img_padded(nbd+1:nbd+M,nbd+1:nbd+N) = img;
img = double(img_padded);
num = 0;
den = 0;
for m = nbd+1:nbd+M
    for n = nbd+1:nbd+N
        slice = img(m-nbd:m+nbd,n-nbd:n+nbd);
        vec = sort(abs(slice(:)-slice(nbd+1,nbd+1)));
        road = sum(vec(2:5),"all");
        w_i = exp(-(road^2)/(2*s_i^2));
        num = num + abs(img_lap(m-nbd,n-nbd))*w_i;
        den = den + w_i;
    end
end
stdev_estimate = sqrt(pi/2)*num/(6*den);
end

