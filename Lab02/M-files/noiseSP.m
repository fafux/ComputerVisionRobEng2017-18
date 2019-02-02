%% Salt & pepper noise
% Add salt & pepper noise with given noise density (noiseDen)

function imgSP = noiseSP(srcImg, noiseDen)

[row,col] = size(srcImg);
maxv = max(max(srcImg)); % research the maximum value of the matrix
noiseMatrix = full(sprand(row,col,noiseDen));
mask0 = noiseMatrix>0 & noiseMatrix<0.5;  
mask1 = noiseMatrix>=0.5; % matlab masking technique
imgSP = srcImg.*(~mask0); % ~mask0 is the negation of mask0
imgSP = imgSP.*(~mask1) + maxv*mask1;