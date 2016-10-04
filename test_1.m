% testing the effect of different image codecs

addpath(genpath('imgs/disparity'));
addpath(genpath('imgs/disparity/disparity_mid_color'));

clear
close all 

dct_data_size = [];
wavelet_data_size = [];
tri_data_size = [];

dct_ssim = [];
wavelet_ssim = [];
tri_ssim = [];

% read images 
%img_dir = 'imgs/disparity/disparity_mid_color/';
%img_dir = 'imgs/disparity/old2/';
img_dir = 'imgs/disparity/test_image/signs/set0/';
left_img_index = [7];
right_img_index = [9];
img_left_matrix = zeros(288,288,3,length(left_img_index));
img_right_matrix = zeros(288,288,3,length(left_img_index));
img_third_matrix = zeros(288,288,3,length(left_img_index));
for i = 1:length(left_img_index)
    xx = 1;
    img_left = imread([img_dir,'im',num2str(left_img_index(i)),'.png']);
    img_left_matrix(:,:,:,xx) = img_left;
    img_right = imread([img_dir,'im',num2str(right_img_index(i)),'.png']);
    img_right_matrix(:,:,:,xx) = img_right;
    xx = xx + 1;
    % compute depth map
    [disparity_map1, foo] = compute_disparity(img_left, img_right);
    
    % TODO: save the depth map so we don't recompute
    
    % compute the watershed map
    Lrgb = watershed_img(img_left);
    
    % TODO: save the watershed map so we don't recompute
    
    % compute joint map
    % TODO: finda way to tell the foreground region in Lrgb
    foreground_color = [76];
    result_map = combine_two_maps(disparity_map1, Lrgb, foreground_color); 
    %refined_disparity_map1 = refine_disparity(binary_disparity_map1);
    [e_map, d_map, final_map] = refine_combined_maps(result_map, Lrgb, foreground_color);
    
    figure;
    subplot(1,5,1);
    imshow(img_left);
    subplot(1,5,2);
    imshow(disparity_map1);
    subplot(1,5,3);
    imshow(Lrgb);
    subplot(1,5,4);
    imshow(result_map);
    subplot(1,5,5);
    imshow(final_map);

    % TODO: save the joint map (and intermediate maps) so we don't recompute
    % compute the dct compression image under different quality settings
    % TODO: save the dct compression image 
    % compute the wavelet compressio image under different quality settings  
    % TODO: save the wavelet compression image 
    % compute the triangularization image under different quality settings 
    % TODO: save the tri compression image 
  %  if image_compressed(image_name)
        %dct_res: 64x64x3xk1
        %w_res: 64x64x3xk2
        %t_res: 64x64x3xk3
        %dct_grey_res:  64x64xk1 
        %w_grey_res: 64x64xk2
        %t_grey_res: 64x64xk3
        %dct_size: 1xk1
        %w_size: 1xk2
        %t_size: 1xk3
        %dct_grey_size: 1xk1
        %w_grey_size: 1xk2
        %t_grey_size: 1xk3
    [dct_res, w_res, t_res, dct_size, w_size, t_size, param_list] = compress_image_three_methods(img_left, final_map);
        % %save(data), configure params
 %   else 
%    load(compressed_image_name);
 %   end
    % all these imgs suppose to be 64 x 64 now. 
    % compute the ssim 
  
    %ground_truth_segment = imresize(imread([img_dir, 'im7gc.png']), [64,64])/ 255;
  %  ground_truth_img = imresize(img_left, [64,64]) .* ground_truth_segment;
 %   dct_ssim = compute_ssim(ground_truth_img, dct_res);
 %   wavelet_ssim = compute_ssim(ground_truth_img, w_res);
 %   tri_ssim = compute_ssim(ground_truth_img, t_res);
    
    % encode the dct/wavelet/triangularization, with SSIM, as a map 
    % TODO: save the result so it can be used for other experiments
 %   dct_size = encode_dct(dct_res);
 %   wavelet_size = encode_wavelet(w_res);
 %   tri_size = encode_tri(t_res);
end

%plot_result()
