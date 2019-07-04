function [U,S,D] = Pca(X)
U = zeros(size(X,2));
S = zeros(size(X,2));

[U,S,D]=svd((X'*X)/size(X,1));

end