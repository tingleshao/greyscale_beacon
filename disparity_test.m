% test the disparity function 
addpath(genpath('imgs/disparity/'))

im3 = imread('im3.png');
im4 = imread('im4.png');
im7 = imread('im7.png');
im8 = imread('im8.png');

disparity_map = compute_disparity(im3, im4);
binary_disparity_map = threshold_disparity(disparity_map);
refined_disparity_map = refine_dispairty(binary_disparity_map);

imshow(refined_disparity_map);
[encoded, data_length] = encode_map(refined_disparity_map, im3);

decoded_image = decode_map(encoded); 

quality = quality_meature(im3, decoded_image);

















