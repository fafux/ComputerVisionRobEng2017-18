%% Gaussian noise
% Add gaussian noise with given standard deviation (stdDev)

function imgGauss = noiseGauss(srcImg, stdDev)

imgGauss = srcImg + stdDev*randn(size(srcImg));