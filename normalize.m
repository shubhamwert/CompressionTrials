function X_norm=normalize(X)
X_mean = mean(X);
X_norm = bsxfun(@minus, X, X_mean);

X_sigma = std(X_norm);
X_norm = bsxfun(@rdivide, X_norm, X_sigma);



end