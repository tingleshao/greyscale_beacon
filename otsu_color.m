I = imread('lennacolor.png');
threshRGB = multithresh(I,2)

value = [0 threshRGB(2:end) 255];
quantRGB = imquantize(I, threshRGB, value);
imshow(quantRGB);
imshow(rgb2gray(quantRGB));
