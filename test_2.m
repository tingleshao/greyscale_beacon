% compares DCT vs wavelet vs triangle

%
clear
close all
signs_dir = 'imgs/disparity/test_image/signs/';
buildings_dir = 'imgs/disparity/test_image/buildings/';
near_indoor_dir = 'imgs/disparity/test_image/near_indoor_objs/';
near_outdoor_dir = 'imgs/disparity/test_image/near_outdoor_objs/';
scenes_dir = 'imgs/disparity/test_image/scenes/';


% for each type, we generate a comparison
%signs_set_lst = [1 2 3 4 5 6 7 8 9 11 13 14 15 16 18 19 20];
signs_set_lst = [18];

buildings_set_lst = 1;
near_indoor_set_lst = [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14];
near_outdoor_set_lst = [];
scenes_set_lst = [];

buildings_orig_img_names = cell(1,1);
buildings_orig_img_names{1} = 'im26.png';

signs_orig_img_names = cell(17,1);
signs = [[13 14]; [20 21]; [39 40]; [46 45]; [51 50]; [57 58]; [61 62];
    [69 70]; [79 80]; [86 87]; [92 91]; [97 98]; [103 102]; [106 105]; [110 111];
    [115 116]; [122 123]; [132 133]; [140 141]; [28 29]; [31 32]];


%for i = 1:17
%    signs_lr = signs(signs_set_lst(i),:);
%    signs_orig_img_names{i} = ['im', num2str(signs_lr(1)), '.png'];
%end

%for i = 0:14
%    indoors_lr = indoors(near_indoor_set_lst(i),:);
%    indoors_orig_img_names{i} = ['im', num2str(indoors_lr(1)), 'png'];
%end

generate_jpeg = 0
generate_jp2k = 0
generate_png = 0

do_sign = 1
if do_sign
    xx = 1
    for i = signs_set_lst
        
        dct_dir = [signs_dir, 'set', num2str(i), '/jpeg_res/'];
        wavelet_dir = [signs_dir, 'set', num2str(i), '/wavelet_res/']
        tri1_dir = [signs_dir, 'set', num2str(i), '/tri1_res/']
        tri2_dir = [signs_dir, 'set', num2str(i), '/tri2_res/']
        tri3_dir = [signs_dir, 'set', num2str(i), '/tri3_res/']
        
        orig_img_dir = [signs_dir, 'set', num2str(i), '/segs/img_left.png']
        xx = xx + 1;
        orig_img = imresize(imread(orig_img_dir),[64,64]);
        
        jpeg_dir = [signs_dir, 'set', num2str(i), '/cjpeg_res/'];
        
        if generate_jpeg
            generate_jpeg_compressed_list(jpeg_dir, orig_img);
        end
        
        %
        [dct_img, dct_size] = read_images_in_dir( dct_dir );
        dct_quality = compute_image_quality(dct_img, orig_img);
        
        
        [wavelet_img, wavelet_size] = read_images_in_dir( wavelet_dir );
        wavelet_quality = compute_image_quality(wavelet_img, orig_img);
        
        [tri1_img, tri1_size] = read_images_in_dir( tri1_dir );
        tri1_quality = compute_image_quality(tri1_img, orig_img);
        
        [tri2_img, tri2_size] = read_images_in_dir( tri2_dir );
        tri2_quality = compute_image_quality(tri2_img, orig_img);
        
        % [tri1_img, tri3_size] = read_images_in_dir( tri3_dir );
        % tri3_quality = compute_image_quality(tri1_img, orig_img);
        
        [jpeg_img, jpeg_size] = read_jpeg_images_in_dir( jpeg_dir );
        jpeg_quality = compute_image_quality(jpeg_img, orig_img);
        
        % [jp2k_img, jp2k_size] = read_images_in_dir( jp2k_dir );
        % jp2k_quality = compute_image_quality(tri1_img, orig_img);
        figure
        hold on
        
        plot(dct_size, dct_quality, '.');
        plot(wavelet_size, wavelet_quality, 'x');
        plot(tri1_size, tri1_quality, 'o');
        plot(tri2_size, tri2_quality, '*');
        plot(jpeg_size, jpeg_quality, '+');
        hold off
        legend('DCT','Wavelet','Tri1','Tri2', 'jpeg')
    end
end

do_indoor = 0
if do_indoor
    xx = 1
    for i = indoor_set_lst
        
        dct_dir = [near_indoor_dir, 'set', num2str(i), '/jpeg_res/'];
        wavelet_dir = [near_indoor_dir, 'set', num2str(i), '/wavelet_res/']
        tri1_dir = [near_indoor_dir, 'set', num2str(i), '/tri1_res/']
        tri2_dir = [near_indoor_dir, 'set', num2str(i), '/tri2_res/']
        tri3_dir = [near_indoor_dir, 'set', num2str(i), '/tri3_res/']
        
        orig_img_dir = [signs_dir, 'set', num2str(i), '/segs/img_left.png']
        xx = xx + 1;
        orig_img = imresize(imread(orig_img_dir),[64,64]);
        
        jpeg_dir = [signs_dir, 'set', num2str(i), '/cjpeg_res/'];
        
        if generate_jpeg
            generate_jpeg_compressed_list(jpeg_dir, orig_img);
        end
        
        %
        [dct_img, dct_size] = read_images_in_dir( dct_dir );
        dct_quality = compute_image_quality(dct_img, orig_img);
        
        
        [wavelet_img, wavelet_size] = read_images_in_dir( wavelet_dir );
        wavelet_quality = compute_image_quality(wavelet_img, orig_img);
        
        [tri1_img, tri1_size] = read_images_in_dir( tri1_dir );
        tri1_quality = compute_image_quality(tri1_img, orig_img);
        
        [tri2_img, tri2_size] = read_images_in_dir( tri2_dir );
        tri2_quality = compute_image_quality(tri2_img, orig_img);
        
        % [tri1_img, tri3_size] = read_images_in_dir( tri3_dir );
        % tri3_quality = compute_image_quality(tri1_img, orig_img);
        
        [jpeg_img, jpeg_size] = read_jpeg_images_in_dir( jpeg_dir );
        jpeg_quality = compute_image_quality(jpeg_img, orig_img);
        
        % [jp2k_img, jp2k_size] = read_images_in_dir( jp2k_dir );
        % jp2k_quality = compute_image_quality(tri1_img, orig_img);
        figure
        hold on
        
        plot(dct_size, dct_quality, '.');
        plot(wavelet_size, wavelet_quality, 'x');
        plot(tri1_size, tri1_quality, 'o');
        plot(tri2_size, tri2_quality, '*');
        plot(jpeg_size, jpeg_quality, '+');
        hold off
        legend('DCT','Wavelet','Tri1','Tri2', 'jpeg')
    end
end
