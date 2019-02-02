%% Translation
% This function translates a single channel input image of desired
% xTranslation and yTranslation; with positive values of xTranslation the
% image will translate on the left and with positive values of yTranslation 
% the image will translate up.

function trasfImg = translation(srcImg, xTranslation, yTranslation)

[row,col] = size(srcImg);
[X,Y] = meshgrid(1:col,1:row);
Xc = X - floor(col/2); 
Yc = Y - floor(row/2);

Xt = (Xc + xTranslation) + floor(col/2);
Yt = (Yc + yTranslation) + floor(row/2);

trasfImg = griddata(X,Y,double(srcImg),Xt,Yt,'linear');