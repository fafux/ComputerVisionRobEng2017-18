clear all
clc
close all

img = imread('i235.png');
% img = imread('tree.png');
figure
imagesc(img), colormap gray, title('Original image')
figure
imhist(img,256), title('Original image histogram')
xlabel('Gray scale'), ylabel('Number of pixel')

img = double(img);

% Add gaussian noise with given standard deviation
imgGauss = noiseGauss(img, 20);
figure,imagesc(imgGauss),colormap gray, title('Image with Gaussian noise')
figure, imhist(uint8(imgGauss),256), title('Image histogram with Gaussian noise')
xlabel('Gray scale'), ylabel('Number of pixel')

% Add salt & pepper noise with given noise density
imgSP = noiseSP(img, 0.2);
figure,imagesc(imgSP),colormap gray, title('Image with salt & pepper noise')
figure, imhist(uint8(imgSP),256), title('Image histogram with salt & pepper noise')
xlabel('Gray scale'), ylabel('Number of pixel')

% Remove the noise from a image with Gaussian noise by using a moving average
imgFilterAve2 = filterMovingAverage(imgGauss, 3);
figure,imagesc(imgFilterAve2),colormap gray,title('Smoothing by averaging the image with Gaussian noise')
figure, imhist(uint8(imgFilterAve2),256), title('Smoothing by averaging histogram (Gauss)')
xlabel('Gray scale'), ylabel('Number of pixel')

% Remove the noise from a image with salt & pepper noise by using a moving average
imgFilterAve = filterMovingAverage(imgSP, 3);
figure,imagesc(imgFilterAve),colormap gray,title('Smoothing by averaging the image with salt & pepper noise')
figure, imhist(uint8(imgFilterAve),256), title('Smoothing by averaging histogram (salt & pepper)')
xlabel('Gray scale'), ylabel('Number of pixel')

% Remove the noise by using a low-pass Gaussian filter
imgFilterGauss = filterGauss(imgGauss, 7);
figure,imagesc(imgFilterGauss),colormap gray,title('Image with Gaussian filter')
figure, imhist(uint8(imgFilterGauss),256), title('Image with Gaussian filter histogram')
xlabel('Gray scale'), ylabel('Number of pixel')

% Remove the noise by using a median filter
imgMedianFilter = filterMedian(imgSP, 3);
figure,imagesc(imgMedianFilter),colormap gray,title('Non-linear filter')
figure, imhist(uint8(imgMedianFilter),256),title('Non-linear filter histogram')
xlabel('Gray scale'), ylabel('Number of pixel')

% Linear filters
[imgLinearFiltered, method] = linearFilters(7, img, 3);
figure,imagesc(imgLinearFiltered),colormap gray,title(['Linear filter of method ' num2str(method)])
figure, imhist(uint8(imgLinearFiltered),256),title(['Linear filter histogram of method ' num2str(method)])
xlabel('Gray scale'), ylabel('Number of pixel')

% Mesh of the original image
figure,mesh(img),title('Image without FFT'),

% Shift the zero frequencies component to center of spectrum of the image
FZ = fftshift(fft2(img));
figure,imagesc(abs(FZ)),colormap gray,title('Image FFT')
figure,mesh(abs(FZ)),title('Image FFT')

% Shift the zero frequencies component to center of spectrum of a low-pass 
% Gaussian filter (101x101 pixels with sigma = 5).  
FH = fspecial('gaussian', 101, 5);
FFZ = fftshift(fft2(FH));
figure,imagesc(abs(FFZ)),colormap gray,title('Gauss FFT')
figure,mesh(abs(FFZ)),title('Gauss FFT')