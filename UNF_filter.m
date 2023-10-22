function [tgt] = UNF_filter(img,nbd,s_s,s_i,s_j)
s_r = 2*estimate_noise_stdev(img,nbd,s_i);
img = double(img);
[M,N] = size(img);
tgt = zeros(M,N);
img_padded = zeros(M+4*nbd,N+4*nbd);
img_padded(2*nbd+1:2*nbd+M,2*nbd+1:2*nbd+N) = img;
img = img_padded;
for m = 2*nbd+1:2*nbd+M
    for n = 2*nbd+1:2*nbd+N
        row_start = m-2*nbd;
        row_end = m+2*nbd;
        col_start = n-2*nbd;
        col_end = n+2*nbd;
        slice = img(row_start:row_end,col_start:col_end);
        h = get_UNF_kernel(slice,nbd,s_s,s_r,s_i,s_j);
        slice_x = slice(nbd+1:3*nbd +1,nbd+1:3*nbd +1);
        tgt(m-2*nbd,n-2*nbd) = sum(h.*slice_x,"all");
    end
end
tgt = uint8(tgt);
end

