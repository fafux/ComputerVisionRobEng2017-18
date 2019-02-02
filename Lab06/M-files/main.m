clearvars
clc
close all

% Read the images
% img1 = imread('Rubik/Rubik1.pgm');
% img2 = imread('Rubik/Rubik2.pgm');
img1 = imread('Mire/Mire1.pgm');
img2 = imread('Mire/Mire2.pgm');

% Show the images
figure, imshow([img1 img2]);

% Load corresponding points
% p1 = load('Rubik/Rubik1.points')';
% p2 = load('Rubik/Rubik2.points')';
p1 = load('Mire/Mire1.points')';
p2 = load('Mire/Mire2.points')';

nPoints = length(p1(1,:)); % Calculate number of points
% p1 & p2 must have dimension (3 x nPoints)
p1 = [p1; ones(1,nPoints)]; % Adding a row of ones at the points matrix
p2 = [p2; ones(1,nPoints)]; % Adding a row of ones at the points matrix

% 8 point algorithm function (version1)
F1 = EightPointsAlgorithm(p1, p2);

result1 = zeros(nPoints, 1);
for i = 1:nPoints
    result1(i) = p2(:,i)' * F1 * p1(:,i);
end

visualizeEpipolarLines(img1, img2, F1, p1(1:2,:)', p2(1:2,:)')

[U1, ~, V1] = svd(F1);
rEpiPoles1 = U1(:,end); % Compute right epipoles
lEpiPoles1 = V1(:,end); % Compute left epipoles
% To have homogeneus coordinates
rEpiPoles1 = rEpiPoles1/rEpiPoles1(3);
lEpiPoles1 = lEpiPoles1/lEpiPoles1(3);

% 8 point algorithm function (version2)
F2 = EightPointsAlgorithmN(p1, p2);

result2 = zeros(nPoints, 1);
for i = 1:nPoints
    result2(i) = p2(:,i)' * F2 * p1(:,i);
end

visualizeEpipolarLines(img1, img2, F2, p1(1:2,:)', p2(1:2,:)')

[U2, ~, V2] = svd(F2);
rEpiPoles2 = U2(:,end); % Compute right epipoles
lEpiPoles2 = V2(:,end); % Compute left epipoles
% To have homogeneus coordinates
rEpiPoles2 = rEpiPoles2/rEpiPoles2(3);
lEpiPoles2 = lEpiPoles2/lEpiPoles2(3);

% Adding a wrong corresponding points to test RANSAC method
p1mat = [p1 , [600; 600; 1]] ;
p2mat = [p2 , [0; 0; 1]] ;

[matlabF] = estimateFundamentalMatrix(p1mat(1:2,:)', p2mat(1:2,:)', 'Method','RANSAC' );

resultmat = zeros(nPoints+1, 1);
for i = 1:nPoints+1
    resultmat(i) = p2mat(:,i)' * matlabF * p1mat(:,i);
end

visualizeEpipolarLines(img1, img2, matlabF, p1mat(1:2,:)', p2mat(1:2,:)')