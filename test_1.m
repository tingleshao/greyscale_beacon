% testing the effect of different image codecs
% signs start from set1

clear
close all
% start from 1 
signs = [[13 14]; [20 21]; [39 40]; [46 45]; [51 50]; [57 58]; [61 62];
    [69 70]; [79 80]; [86 87]; [92 91]; [97 98]; [103 102]; [106 105]; [110 111];
    [115 116]; [122 123]; [132 133]; [140 141]; [28 29]; [31 32]];
signs_f = [[179 0]; [179 0]; [179 76]; [203 0]; [151 0]; [179 0]; [179 0];
    [76 0]; [179 0]; [104 0]; [29 0]; [29 0]; [226 0]; [29 0]; [151 0];
    [76 0]; [29 0]; [179 0]; [226 29]; [179 0]; [29 0]];
signs_do = [1; 1; 1; 1; 1; 1; 1;
    1; 1; 0; 1; 0; 1; 1; 1;
    1; 0; 1; 1; 1; 0];
signs_do2 = [0;0;0;1;1;1;1;
    1;1;0;1;0;1;1;1;
    1;0;1;1;1;0];
% start from 1
buildings = [[26 29]; [8 9]; [15 10]; [19 16]; [33 30]; [20 25]];
buildings_f = [[179 29]; [179 0]; [179 0]; [179 0]; [179 0]; [76 0]];
buildings_do = [0; 1; 1; 1; 1; 1];
buildings_do2 = [0; 0; 0; 0; 0; 1];

% start from 0
indoors = [[3 6]; [11 13]; [33 36]; [7 8]; [44 45]; [46 51]; [1 2]; [1 2]];
indoors_f = [[179 0]; [179 0]; [179 0]; [29 0]; [203 0]; [179 0]; [179 0]; [179 0]];
indoors_do = [0; 0; 0; 0; 0; 0; 1; 1];

% start from 0
outdoors = [[3 6]; [7 9]; [11 13];];
outdoors_f = [[179 0]; [179 0]; [179 0]];
outdoors_do = [1; 1; 1];

% start from 0
scenes = [[3 4]];
scenes_f = [[179 0]];
scenes_do = [1];


addpath(genpath('imgs/disparity'));
addpath(genpath('imgs/disparity/disparity_mid_color'));

dct_data_size = [];
wavelet_data_size = [];
tri_data_size = [];

dct_ssim = [];
wavelet_ssim = [];
tri_ssim = [];

% read images
%img_dir = 'imgs/disparity/disparity_mid_color/';
%img_dir = 'imgs/disparity/old2/';
for k = 1:8
    %img_dir = ['imgs/disparity/test_image/scenes/set', num2str(k-1), '/'];
    img_dir = ['imgs/disparity/test_image/near_indoor_objs/set', num2str(k-1), '/'];

    if indoors_do(k)
        lr = indoors(k,:);
        left_img_index = lr(1);
        right_img_index = lr(2);
        img_left_matrix = zeros(288,288,3,length(left_img_index));
        img_right_matrix = zeros(288,288,3,length(left_img_index));
        img_third_matrix = zeros(288,288,3,length(left_img_index));
        for i = 1:length(left_img_index)
            
            if exist([img_dir, 'segs/img_left.png'], 'file') ~= 2
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
                foreground_color = indoors_f(k,:)
                result_map = combine_two_maps(disparity_map1, Lrgb, foreground_color);
                %refined_disparity_map1 = refine_disparity(binary_disparity_map1);
                [e_map, d_map, final_map] = refine_combined_maps(result_map, Lrgb, foreground_color);
                imwrite(img_left, [img_dir, 'segs/img_left.png']);
                imwrite(disparity_map1, [img_dir, 'segs/disparity_map1.png']);
                imwrite(Lrgb, [img_dir, 'segs/Lrgb.png']);
                imwrite(result_map, [img_dir, 'segs/result_map.png']);
                imwrite(final_map, [img_dir, 'segs/final_map.png']);
            else
                img_left = imread([img_dir, 'segs/img_left.png']);
                disparity_map1 = imread([img_dir, 'segs/disparity_map1.png']);
                Lrgb = imread([img_dir, 'segs/Lrgb.png']);
                result_map = imread([img_dir, 'segs/result_map.png']);
                final_map = imread([img_dir, 'segs/final_map.png']);
            end
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
            [dct_res, w_res, t_res, dct_size, w_size, t_size, param_list] = compress_image_three_methods(img_left, final_map, img_dir);
            
            
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
    end
end

%plot_result()
