%% Implement the 8 points algorithm to estimate the fundamental matrix F (version1)

function F = EightPointsAlgorithm(p1, p2)

nPoints = length(p1(1,:)); % Calculate number of points
A = zeros(nPoints, 9);

% Write the matrix A
A = [p2(1,:)'.*p1(1,:)' p2(1,:)'.*p1(2,:)' p2(1,:)' ...
     p2(2,:)'.*p1(1,:)' p2(2,:)'.*p1(2,:)' p2(2,:)' ...
     p1(1,:)'  p1(2,:)' ones(nPoints,1) ]; 

[~, ~, V] = svd(A); % Compute the SVD decomposition of A 
f = V(:,end); % The least square solution is in the last column of V
F = reshape(f, 3, 3); % Reshape column vector f so to obtain a matrix F (3x3)
F = F'; % The reshape returns a transposed matrix respect to the wanted matrix F
[U, D, V] = svd(F);
D(3,3) = 0; % Enforce rank of F to be 2 (put the smallest value to 0)
F = U*D*V'; % Recompute the final F
