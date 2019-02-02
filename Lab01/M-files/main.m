%% Computer Vision Lab session n. 1
% Image warping and bilinear interpolation
% Fabio Fusaro, Davide Torielli, Luca Morando

imageCol = imread('boccadasse.jpg');
% imageCol = imread('flower.jpg');
imgGray = rgb2gray(imageCol);
figure
imagesc(imgGray), colormap gray, title('Original image')

traImg = translation(imgGray, 70, 50);
figure
imagesc(traImg), colormap gray, title('Only translation')

sheImg = shear(imgGray, 0.7, 0);
figure
imagesc(sheImg), colormap gray, title('Only vertical shear')

rotImg = rotation(imgGray, pi/4);
figure
imagesc(rotImg), colormap gray, title('Only rotation')

traRotImg = rotation(traImg, pi/4);
figure
imagesc(traRotImg), colormap gray, title('Translation and rotation')

traSheImg = shear(traImg, 0.7, 0);
figure
imagesc(traSheImg), colormap gray, title('Translation and vertical shear')