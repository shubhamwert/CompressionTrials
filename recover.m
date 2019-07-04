function X_rec=recover(Z,U,K);
X_rec = zeros(size(Z, 1), size(U, 1));


for i=1:size(Z, 1)
    v = Z(i, :)';
    for j=1: size(U, 1)
        X_rec(i, j) = v' * U(j, 1:K)';
    end
end



end