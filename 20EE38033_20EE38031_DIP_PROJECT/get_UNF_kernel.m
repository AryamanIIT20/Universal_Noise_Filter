function [h] = get_UNF_kernel(slice,nbd,s_s,s_r,s_i,s_j)
slice_x = slice(nbd+1:3*nbd +1,nbd+1:3*nbd +1);
vec = sort(abs(slice_x(:)-slice_x(nbd+1,nbd+1)));
road_x = sum(vec(1:5),"all");
M = 2*nbd +1;
N = 2*nbd +1;
h = zeros(M,N);
m0 = 2*nbd +1;
n0 = 2*nbd +1;
r = 0;
for m = nbd+1:nbd+M
    for n = nbd+1:nbd+N
        w_s = exp(-((m-m0)^2 + (n-n0)^2)/(2*s_s^2));
        lr = m-nbd;
        ur = m+nbd;
        lc = n-nbd;
        uc = n+nbd;
        slice_y = slice(lr:ur,lc:uc);
        vec = sort(abs(slice_y(:)-slice_y(nbd+1,nbd+1)));
        road_y = sum(vec(1:5),"all"); % since first element is always zero
        s_i = 25 + 30/(1+exp((road_y-60)));  % Modification by Sayan
        w_i = exp(-(road_y^2)/(2*s_i^2));
        w_r = exp(-((slice(m,n)-slice(m0,n0))^2)/(2*s_r^2));
        J = 1 - exp(-(((road_x+road_y)/2)^2)/(2*s_j^2));
        h(m-nbd,n-nbd) = w_s*(w_r^(1-J))*(w_i^J);
        r = r + h(m-nbd,n-nbd);
    end
end
h = h/r;
end

