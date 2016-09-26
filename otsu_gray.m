I = imread('lenna.jpg');

thresh = multithresh(I,3);
seg_I = imquantize(I,thresh);
RGB = label2rgb(seg_I);
figure;
imshow(RGB)
axis off
title('RGB Segmented Image')