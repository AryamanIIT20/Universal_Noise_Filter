function tgt = my_median_filter(img,nbd_size)
nbd = nbd_size;
img = double(img);
[M,N] = size(img);
tgt = zeros(M,N);
img_padded = zeros(M+2*nbd,N+2*nbd);
img_padded(nbd+1:nbd+M,nbd+1:nbd+N) = img;
img = img_padded;
for m = nbd+1:nbd+M
    for n = nbd+1:nbd+N
        row_start = m-nbd;
        row_end = m+nbd;
        col_start = n-nbd;
        col_end = n+nbd;
        slice = img(row_start:row_end,col_start:col_end);
        tgt(m-nbd,n-nbd) = median(slice(:));
    end
end
tgt = uint8(tgt);
end

