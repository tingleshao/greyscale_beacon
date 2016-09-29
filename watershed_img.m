% does watershed segmentation on a given image 

function [ Lrgb ] = watershed_img( input_img, verbose)
input_img = rgb2gray(input_img);
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(input_img), hy, 'replicate');
Ix = imfilter(double(input_img), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
figure;
imshow(gradmag, []), title('Gradient magnitude');
L = watershed(gradmag);
Lrgb = label2rgb(L);
figure, imshow(Lrgb), title('Watershed transform of gradient magnitude (Lrgb)');
se = strel('disk', 20);
Io = imopen(input_img, se);
figure, imshow(Io), title('Opening (Io)');
Ie = imerode(input_img, se);
Iobr = imreconstruct(Ie, input_img);
figure, imshow(Iobr), title('Opening-by-reconstruction (Iobr)');
Ioc = imclose(Io, se);
figure, imshow(Ioc), title('Opening-closing (Ioc)');
Iobrd = imdilate(Iobr, se);
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
figure, imshow(Iobrcbr), title('Opening-closing by reconstruction (Iobrcbr)');
fgm = imregionalmax(Iobrcbr);
figure, imshow(fgm), title('Regional maxima of opening-closing by reconstruction (fgm)');
I2 = input_img;
I2(fgm) = 255;
figure, imshow(I2), title('Regional maxi a superimposed on original image (I2)');
se2 = strel(ones(5,5));
fgm2 = imclose(fgm, se2);
fgm3 = imerode(fgm2, se2);
fgm4 = bwareaopen(fgm3, 20);
I3 = input_img;
I3(fgm4) = 255;
figure, imshow(I3), title('Modified regional maxima superimposed on original image (fgm4)');
level = graythresh(Iobrcbr);
bw = im2bw(Iobrcbr, level); 
figure, imshow(bw), title('Threshold opening-closing by reconstruction (bw)');
D = bwdist(bw);
DL = watershed(D);
bgm = DL == 0;
figure, imshow(bgm), title('Watershed ridge lines (bgm)')

gradmag2 = imimposemin(gradmag, bgm | fgm4);
L = watershed(gradmag2);
I4 = input_img;
I4(imdilate(L==0, ones(3,3)) | bgm | fgm4) = 255;
figure, imshow(I4), title('Markers and objet boundaries superimposed on original image (I4)');
Lrgb = label2rgb(L, 'jet', 'w', 'shuffle');
figure, imshow(Lrgb), title('Colored watershed label matrix (Lrgb)')
figure, imshow(input_img)
hold on 
himage = imshow(Lrgb);
himage.AlphaData = 0.3;
title('Lrgb superimposed transparently on original image');


end

