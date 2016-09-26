close all;
I = imread('lenna.jpg');

BW = edge(I,'Canny');
imshow(BW);
