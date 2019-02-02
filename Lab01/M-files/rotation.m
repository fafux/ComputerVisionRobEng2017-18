%% Rotation
% This function rotates a single channel input image of desired
% theta angle

function trasfImg = rotation(srcImg, theta)

[row,col] = size(srcImg);
[X,Y] = meshgrid(1:col,1:row);
Xc = X - floor(col/2); 
Yc = Y - floor(row/2);

Xr = Xc * cos(theta) - Yc * sin(theta) + floor(col/2);
Yr = Xc * sin(theta) + Yc * cos(theta) + floor(row/2);

trasfImg = griddata(X,Y,double(srcImg),Xr,Yr,'linear');