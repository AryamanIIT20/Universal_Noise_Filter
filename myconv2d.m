function [img_conv] = myconv2d(img,kernel)
kernel = rot90(kernel,2);
[h,w] = size(kernel);
M = (w-1)/2;
N = (h-1)/2;
[ht,wt] = size(img);
img_padded = zeros(ht+2*N,wt+2*M);
img_padded(N+1:N+ht,M+1:M+wt) = img;
img_conv = zeros(size(img));
img_op = double(img_padded);
for x = 1:wt
    for y = 1:ht
        slice = img_op(y:y+2*N,x:x+2*M);
        img_conv(y,x) = sum(slice.*kernel,"all");
    end
end
% img_conv = uint8(img_conv);
end

