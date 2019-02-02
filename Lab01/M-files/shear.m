%% Shear
% This function shears a single channel input image of desired
% coefficent (shearFactor).

function trasfImg = shear(srcImg, shearFactorVertical, shearFactorHorizontal)

[row,col] = size(srcImg);
[X,Y] = meshgrid(1:col,1:row);
Xc = X - floor(col/2); 
Yc = Y - floor(row/2);

Xs = Xc + shearFactorVertical * Yc + floor(col/2);
Ys = shearFactorHorizontal * Xc + Yc + floor(row/2);

trasfImg = griddata(X,Y,double(srcImg),Xs,Ys,'linear');