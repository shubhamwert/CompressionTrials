function Z = projectData(X_norm, U, K)

Z = zeros(size(X_norm, 1), K);

for i=1:size(X_norm, 1)
    X_norm = X_norm(i, :)';
    Z(i, :) = X_norm' * U(:, 1:K);
end


end