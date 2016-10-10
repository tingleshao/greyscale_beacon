clear
close all
img = imread('imgs/disparity/old2/im7.png');

map = imread('imgs/exp_save/final.png');
small_map = imresize(map, [64,64]);

small_map(small_map < 10) = 0;
small_map(small_map > 0) = 255;
background = imresize(imresize(img,[3,3]),[64,64]);

triangularize_res = triangularization(small_map);
curr_triangularize_res = triangularize_res;
figure;
for i = 2:20
    if (size(curr_triangularize_res.Points,1) <= 3)
        break
    end
    curr_triangularize_res = reduce_triangle(curr_triangularize_res, 1);
    subplot(4,5,20-i+2);
    %   plot_img_with_tri(input_image, curr_triangularize_res)
    %   imshow(curr_img_small, curr_triangularize_res);
    [canvas, foo] = reduce_img_from_tri(imresize(img, [64,64]), curr_triangularize_res, background);
    %   [bits , raw_bits]= compute_tri_size(curr_triangularize_res);
    %   title([num2str(bits+background_size),',', num2str(raw_bits)]);
    numtri = size(curr_triangularize_res.ConnectivityList,1);
    %   imwrite(canvas, [work_dir, 'tri1_res/numtri_', num2str(numtri), '_size_', num2str(bits+background_size), '.png']);
end
