% this a first test that tests the map quality???
addpath(genpath('imgs/disparity/'));
addpath(genpath('imgs/disparity/disparity_mid_color/'));
clear
close all
%im9 = imread('imgs/disparity/disparity_mid_color/im9.jpg');
%im10 = imread('imgs/disparity/disparity_mid_color/im10.jpg');
%im11 = imread('imgs/disparity/disparity_mid_color/im11.jpg');

%im9 = imread('imgs/disparity/disparity_mid_color/im18.jpg');
%im10 = imread('imgs/disparity/disparity_mid_color/im19.jpg');
%im11 = imread('imgs/disparity/disparity_mid_color/im20.jpg');

im9 = imread('imgs/disparity/old/im7s.png');
im10 = imread('imgs/disparity/old/im8s.png');
Lrgb = watershed_img(im9);

im9t(:,:,1) = im9(:,:,1)';
im9t(:,:,2) = im9(:,:,2)';
im9t(:,:,3) = im9(:,:,3)';

im10t(:,:,1) = im10(:,:,1)';
im10t(:,:,2) = im10(:,:,2)';
im10t(:,:,3) = im10(:,:,3)';

%im11t(:,:,1) = im11(:,:,1)';
%im11t(:,:,2) = im11(:,:,2)';
%im11t(:,:,3) = im11(:,:,3)';

[disparity_map1, foo] = compute_disparity(im9, im10);
result_map = combine_two_maps(disparity_map1, Lrgb);
%disparity_map2 = compute_disparity(im10t, im11t);
%disparity_map3 = compute_disparity(im9t, im11t);
%
binary_disparity_map1 = threshold_disparity(disparity_map1);
%binary_disparity_map2 = threshold_disparity(disparity_map2);
%binary_disparity_map3 = threshold_disparity(disparity_map3);

refined_disparity_map1 = refine_disparity(binary_disparity_map1);
%refined_disparity_map2 = refine_disparity(binary_disparity_map2);
%refined_disparity_map3 = refine_disparity(binary_disparity_map3);

[e_map, d_map, final_map] = refine_combined_maps(result_map, Lrgb);


figure;
subplot(4,3,1);
imshow(disparity_map1);
title('depth map (d)')

subplot(4,3,2);
%imshow(disparity_map2);
title('watershed segmentation (w)')
imshow(Lrgb);
%subplot(4,3,3);
%imshow(disparity_map3);

subplot(4,3,4);
imshow(binary_disparity_map1);
title('threshold on d (x)');
subplot(4,3,5);
%imshow(binary_disparity_map2);
imshow(result_map);
title('d && w (a)');
subplot(4,3,6);
%imshow(binary_disparity_map3);
imshow(e_map);
title('erosion on a (e)');

subplot(4,3,7);
imshow(refined_disparity_map1);
title('refinement on x (y)');
subplot(4,3,8);
%imshow(refined_disparity_map2);
imshow(d_map);
title('dilation on e (d)');
subplot(4,3,9);
%imshow(refined_disparity_map3);
imshow(final_map);
title('adjust d with w');
subplot(4,3,12);

imshow(find_boundary(uint8(final_map)));

subplot(4,3,10);
imshow(im9);
subplot(4,3,11);
imshow(im10);

[dct_res, w_res, t_res] = compress_image_three_methods(im9, final_map);

test_img_with_tri_plot = 0;
if test_img_with_tri_plot
    figure
    h2 = imshow(imresize(rgb2gray(im9),[64,64]));
    ax2 = ancestor(h2, 'axes');
    ax2.Visible = 'on';
    hold(ax2, 'on');
    triplot(t_res, 'w', 'Parent', ax2);
end

save_exp_images = 0;
% save the intermediate result
if save_exp_images
    imwrite(disparity_map1, 'imgs/exp_save/d.png');
    imwrite(Lrgb, 'imgs/exp_save/w.png');
    imwrite(binary_disparity_map1,'imgs/exp_save/x.png');
    imwrite(result_map,'imgs/exp_save/s.png');
    imwrite(e_map,'imgs/exp_save/e.png');
    imwrite(refined_disparity_map1,'imgs/exp_save/y.png');
    imwrite(d_map,'imgs/exp_save/d.png');
    imwrite(final_map,'imgs/exp_save/final.png');
end

%subplot(4,3,12);
%imshow(im11t);

%[encoded, data_length] = encode_map(refined_disparity_map1, im9);
%decoded_image = decode_map(encoded);
%quality = quality_meature(im3, decoded_image);

%quality
%