% test the disparity function 
addpath(genpath('imgs/disparity/'))

im3 = imread('im3.png');
im4 = imread('im4.png');
im7 = imread('im7.png');
im8 = imread('im8.png');

disparityMap = compute_disparity(im3, im4);








