% this a first test that tests the map quality???
addpath(genpath('imgs/disparity/'));
addpath(genpath('imgs/disparity/disparity_mid_color/'));

%im9 = imread('imgs/disparity/disparity_mid_color/im9.jpg');
%im10 = imread('imgs/disparity/disparity_mid_color/im10.jpg');
%im11 = imread('imgs/disparity/disparity_mid_color/im11.jpg');


%im9 = imread('imgs/disparity/disparity_mid_color/im18.jpg');
%im10 = imread('imgs/disparity/disparity_mid_color/im19.jpg');
%im11 = imread('imgs/disparity/disparity_mid_color/im20.jpg');

im9 = imread('imgs/disparity/old/im7s.png');
im10 = imread('imgs/disparity/old/im8s.png');
Lrgb = watershed_img(im9);

% TODO: why disparity map is binary? 

im9t(:,:,1) = im9(:,:,1)';
im9t(:,:,2) = im9(:,:,2)';
im9t(:,:,3) = im9(:,:,3)';

im10t(:,:,1) = im10(:,:,1)';
im10t(:,:,2) = im10(:,:,2)';
im10t(:,:,3) = im10(:,:,3)';

%im11t(:,:,1) = im11(:,:,1)';
%im11t(:,:,2) = im11(:,:,2)';
%im11t(:,:,3) = im11(:,:,3)';

disparity_map1 = compute_disparity(im9, im10);
%disparity_map2 = compute_disparity(im10t, im11t);
%disparity_map3 = compute_disparity(im9t, im11t);
%
binary_disparity_map1 = threshold_disparity(disparity_map1);
%binary_disparity_map2 = threshold_disparity(disparity_map2);
%binary_disparity_map3 = threshold_disparity(disparity_map3);

refined_disparity_map1 = refine_disparity(binary_disparity_map1);
%refined_disparity_map2 = refine_disparity(binary_disparity_map2);
%refined_disparity_map3 = refine_disparity(binary_disparity_map3);
figure;
subplot(4,3,1);
imshow(disparity_map1);
subplot(4,3,2);
%imshow(disparity_map2);
imshow(Lrgb);
%subplot(4,3,3);
%imshow(disparity_map3);

subplot(4,3,4);
imshow(binary_disparity_map1);
%subplot(4,3,5);
%imshow(binary_disparity_map2);
%subplot(4,3,6);
%imshow(binary_disparity_map3);

subplot(4,3,7);
imshow(refined_disparity_map1);
%subplot(4,3,8);
%imshow(refined_disparity_map2);
%subplot(4,3,9);
%imshow(refined_disparity_map3);


subplot(4,3,10);
imshow(im9);
subplot(4,3,11);
imshow(im10);
%subplot(4,3,12);
%imshow(im11t);





%[encoded, data_length] = encode_map(refined_disparity_map1, im9);
%decoded_image = decode_map(encoded); 
%quality = quality_meature(im3, decoded_image);

%quality
% 