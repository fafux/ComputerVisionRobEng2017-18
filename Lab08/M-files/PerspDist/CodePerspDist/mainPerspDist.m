clc;
clear all;
close all;

I1 = imread('../ImagesPerspDist/cathedral.jpg'); % put here the image name affected by perspective distorsion

disp('Choose 4 points delimiting edges of a distorted shape...');
figure, imshow(I1), title('Select 4 points'), hold on;
X1 = zeros(4,2);
for i = 1 : 4
    X1(i,:) = ginput(1);
    plot(X1(i,1), X1(i,2), 'sr');
    text(X1(i,1)-20, X1(i,2)-20, sprintf('%d', i));
end
X1 = [X1'; ones(1,4)];

disp('Choose 4 points delimiting virtual edges of the new non-distorted shape...');
X2 = zeros(4,2);
for i = 1 : 4
    X2(i,:) = ginput(1);
    plot(X2(i,1), X2(i,2), 'sg');
    text(X2(i,1)-20, X2(i,2)-20, sprintf('%d', i));
end
X2 = [X2'; ones(1,4)];

% estimate the homography
H = my_homography(X1,X2);

% direct mapping
I2 = directMapping(I1, H);
figure, imshow(uint8(I2)), title('Direct mapping');

% inverse mapping
I3 = inverseMapping(I1, H);
figure, imshow(uint8(I3)), title('Inverse mapping');

% % normalization of the points
% [X1n, T1] = normalise2dpts(X1);
% [X2n, T2] = normalise2dpts(X2);
% 
% % estimate the homography
% Hn = my_homography(X1n,X2n);
% 
% % de-normalize H
% Hn = inv(T2) * Hn * T1;
% 
% % direct mapping
% I2 = directMapping(I1, Hn);
% figure, imshow(uint8(I2)), title('Direct mapping with normalized points');
% 
% % inverse mapping
% I3 = inverseMapping(I1, Hn);
% figure, imshow(uint8(I3)), title('Inverse mapping with normalized points');

