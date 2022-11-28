function [N,W] = Weight(H1,H2,M)
    [N,W] = UniformWeight(H1,M);
    if H2 > 0
        [N2,W2] = UniformWeight(H2,M);
        N = N + N2;
        W = [W;W2/2+1/(2*M)];
    end
    W(W==0) = 1e-6;
end

function [N,W] = UniformWeight(H,M)
    N = nchoosek(H+M-1,M-1);
    Temp = nchoosek(1:H+M-1,M-1)-repmat(0:M-2,nchoosek(H+M-1,M-1),1)-1;
    W = zeros(N,M);
    W(:,1) = Temp(:,1)-0;
    for i = 2 : M-1
        W(:,i) = Temp(:,i)-Temp(:,i-1);
    end
    W(:,end) = H-Temp(:,end);
    W = W/H;
end