img = imread("cameraman.tif");
p = 0.05;
[M,N] = size(img);
% img_noisy = img;
% for i = 1:M
%     for j = 1:N
%         k = rand;
%         q = rand;
%         if k<p
%             img_noisy(i,j) = uint8(255*q);
%         end
%     end
% end
img = imnoise(img,"salt & pepper",p);


nbd = 1;
img_padded = zeros(M+2*nbd,N+2*nbd);
img_padded(nbd+1:nbd+M,nbd+1:nbd+N) = img;
img = double(img_padded);
road_vec = [];
for m = nbd+1:nbd+M
    for n = nbd+1:nbd+N
        slice = img(m-nbd:m+nbd,n-nbd:n+nbd);
        vec = sort(abs(slice(:)-slice(nbd+1,nbd+1)));
        road = sum(vec(1:5),"all");
        road_vec = [road_vec;road];
    end
end
plot(road_vec,".");