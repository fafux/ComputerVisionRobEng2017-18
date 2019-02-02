%% Implement the 8 points algorithm to estimate the fundamental matrix F (version2)

function F = EightPointsAlgorithmN(p1, p2)

% Normalize the points using the function normalise2dpts provided
[nP1, T1] = normalise2dpts(p1);
[nP2, T2] = normalise2dpts(p2);

nPoints = length(nP1(1,:)); % Calculate number of points
A = zeros(nPoints, 9);

% Write the matrix A
A = [nP2(1,:)'.*nP1(1,:)' nP2(1,:)'.*nP1(2,:)' nP2(1,:)' ...
     nP2(2,:)'.*nP1(1,:)' nP2(2,:)'.*nP1(2,:)' nP2(2,:)' ...
     nP1(1,:)'  nP1(2,:)' ones(nPoints,1) ]; 

[~, ~, V] = svd(A); % Compute the SVD decomposition of A 
f = V(:,end); % The least square solution is in the last column of V
F = reshape(f, 3, 3); % Reshape column vector f so to obtain a matrix F (3x3)
F = F'; % The reshape returns a transposed matrix respect to the wanted matrix F
[U, D, V] = svd(F);
D(3,3) = 0; % Enforce rank of F to be 2 (put the smallest value to 0)
F = U*D*V';

F = T2' * F * T1;  % Recompute the final F de-normalizing the F
