% does watershed segmentation on a given image 

function [ Lrgb ] = watershed_img( input_img, verbose)
input_img = rgb2gray(input_img);
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(input_img), hy, 'replicate');
Ix = imfilter(double(input_img), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
figure;
subplot(3,5,1);
imshow(gradmag, []), title('Gradient magnitude');
L = watershed(gradmag);
Lrgb = label2rgb(L);
subplot(3,5,2);imshow(Lrgb), title('Watershed transform of gradient magnitude (Lrgb)');
se = strel('disk', 20);
Io = imopen(input_img, se);
subplot(3,5,3); imshow(Io), title('Opening (Io)');
Ie = imerode(input_img, se);
Iobr = imreconstruct(Ie, input_img);
subplot(3,5,4); imshow(Iobr), title('Opening-by-reconstruction (Iobr)');
Ioc = imclose(Io, se);
subplot(3,5,5); imshow(Ioc), title('Opening-closing (Ioc)');
Iobrd = imdilate(Iobr, se);
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
subplot(3,5,6); imshow(Iobrcbr), title('Opening-closing by reconstruction (Iobrcbr)');
fgm = imregionalmax(Iobrcbr);
subplot(3,5,7);  imshow(fgm), title('Regional maxima of opening-closing by reconstruction (fgm)');
I2 = input_img;
I2(fgm) = 255;
subplot(3,5,8);  imshow(I2), title('Regional maxi a superimposed on original image (I2)');
se2 = strel(ones(5,5));
fgm2 = imclose(fgm, se2);
fgm3 = imerode(fgm2, se2);
fgm4 = bwareaopen(fgm3, 20);
I3 = input_img;
I3(fgm4) = 255;
subplot(3,5,9);  imshow(I3), title('Modified regional maxima superimposed on original image (fgm4)');
level = graythresh(Iobrcbr);
bw = im2bw(Iobrcbr, level); 
subplot(3,5,10);  imshow(bw), title('Threshold opening-closing by reconstruction (bw)');
D = bwdist(bw);
DL = watershed(D);
bgm = DL == 0;
subplot(3,5,11);  imshow(bgm), title('Watershed ridge lines (bgm)')

gradmag2 = imimposemin(gradmag, bgm | fgm4);
subplot(3,5,15); imshow(gradmag2), title('gradmag2');
L = watershed(gradmag2);
I4 = input_img;
I4(imdilate(L==0, ones(3,3)) | bgm | fgm4) = 255;
subplot(3,5,12);  imshow(I4), title('Markers and objet boundaries superimposed on original image (I4)');
Lrgb = label2rgb(L, 'jet', 'w', 'shuffle');
subplot(3,5,13);  imshow(Lrgb), title('Colored watershed label matrix (Lrgb)')
subplot(3,5,14);  imshow(input_img)
hold on 
himage = imshow(Lrgb);
himage.AlphaData = 0.3;
title('Lrgb superimposed transparently on original image');


end

