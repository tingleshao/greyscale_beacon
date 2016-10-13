% test the effect of different number of beacons


if 0
    clear
    close all
    signs_dir = 'imgs/disparity/test_image/signs/';
    
    % for each type, we generate a comparison
    signs_set_lst = [1 2 3 4 5 6 7 8 9 11 13 14 15 16 18 19];
    %signs_set_lst = [18];
    
    %buildings_set_lst = 1;
    %near_indoor_set_lst = [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14];
    %near_outdoor_set_lst = [];
    %scenes_set_lst = [];
    
    %buildings_orig_img_names = cell(1,1);
    %buildings_orig_img_names{1} = 'im26.png';
    
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
    
    dct_quality = [];
    wavelet_quality = [];
    tri1_quality = [];
    tri2_quality = [];
    
    dct_map = containers.Map;
    wavelet_map = containers.Map;
    tri1_map = containers.Map;
    tri2_map = containers.Map;
    
    [data_volume, battery_life] = volume_for_beacons_and_time(1, 0.5);
    
    for i = signs_set_lst
        dct_dir = [signs_dir, 'set', num2str(i), '/jpeg_res/'];
        wavelet_dir = [signs_dir, 'set', num2str(i), '/wavelet_res/']
        tri1_dir = [signs_dir, 'set', num2str(i), '/tri1_res/']
        tri2_dir = [signs_dir, 'set', num2str(i), '/tri2_res/']
        tri3_dir = [signs_dir, 'set', num2str(i), '/tri3_res/']
        
        orig_img_dir = [signs_dir, 'set', num2str(i), '/segs/img_left.png']
        orig_img = imresize(imread(orig_img_dir),[64,64]);
        
        jpeg_dir = [signs_dir, 'set', num2str(i), '/cjpeg_res/'];
        
        [dct_img, dct_size] = read_images_in_dir( dct_dir );
        dct_quality = compute_image_quality(dct_img, orig_img);
        for j = 1:length(dct_size)
            curr_size = dct_size(j);
            curr_quality = dct_quality(j);
            for k = 1:length(data_volume)
                curr_dv = data_volume(k);
                curr_month = battery_life(k);
                if curr_size <= curr_dv
                    if isKey(dct_map, num2str(curr_month))
                        quality_lst = dct_map(num2str(curr_month));
                        dct_map(num2str(curr_month)) = [quality_lst, curr_quality];
                    else
                        dct_map(num2str(curr_month)) = [curr_quality];
                    end
                    break
                end
            end
        end
        
        [wavelet_img, wavelet_size] = read_images_in_dir( wavelet_dir );
        wavelet_quality = compute_image_quality(wavelet_img, orig_img);
        for j = 1:length(wavelet_size)
            curr_size = wavelet_size(j);
            curr_quality = wavelet_quality(j);
            for k = 1:length(data_volume)
                curr_dv = data_volume(k);
                curr_month = battery_life(k);
                if curr_size <= curr_dv
                    if isKey(wavelet_map, num2str(curr_month))
                        quality_lst = wavelet_map(num2str(curr_month));
                        wavelet_map(num2str(curr_month)) = [quality_lst, curr_quality];
                    else
                        wavelet_map(num2str(curr_month)) = [curr_quality];
                    end
                    break
                end
            end
        end
        
        [tri1_img, tri1_size] = read_images_in_dir( tri1_dir );
        tri1_quality = compute_image_quality(tri1_img, orig_img);
        for j = 1:length(tri1_size)
            curr_size = tri1_size(j);
            curr_quality = tri1_quality(j);
            for k = 1:length(data_volume)
                curr_dv = data_volume(k);
                curr_month = battery_life(k);
                if curr_size <= curr_dv
                    if isKey(tri1_map, num2str(curr_month))
                        quality_lst = tri1_map(num2str(curr_month));
                        tri1_map(num2str(curr_month)) = [quality_lst, curr_quality];
                    else
                        tri1_map(num2str(curr_month)) = [curr_quality];
                    end
                    break
                end
            end
        end
        
        [tri2_img, tri2_size] = read_images_in_dir( tri2_dir );
        tri2_quality = compute_image_quality(tri2_img, orig_img);
        for j = 1:length(tri2_size)
            curr_size = tri2_size(j);
            curr_quality = tri2_quality(j);
            for k = 1:length(data_volume)
                curr_dv = data_volume(k);
                curr_month = battery_life(k);
                if curr_size <= curr_dv
                    if isKey(tri2_map, num2str(curr_month))
                        quality_lst = tri2_map(num2str(curr_month));
                        tri2_map(num2str(curr_month)) = [quality_lst, curr_quality];
                    else
                        tri2_map(num2str(curr_month)) = [curr_quality];
                    end
                    break
                end
            end
        end
        
        % [tri1_img, tri3_size] = read_images_in_dir( tri3_dir );
        % tri3_quality = compute_image_quality(tri1_img, orig_img);
        
        %     [jpeg_img, jpeg_size] = read_jpeg_images_in_dir( jpeg_dir );
        %     jpeg_quality = compute_image_quality(jpeg_img, orig_img);
        
        % [jp2k_img, jp2k_size] = read_images_in_dir( jp2k_dir );
        % jp2k_quality = compute_image_quality(tri1_img, orig_img);
        
    end
    
    figure
    hold on
    dct_month_quality = [];
    wavelet_month_quality = [];
    tri1_month_quality = [];
    tri2_month_quality = [];
    dct_month = [];
    wavelet_month = [];
    tri1_month = [];
    tri2_month = [];
    for i = 1:length(battery_life)
        month = battery_life(i);
        if isKey(dct_map, num2str(month))
            dct_month = [dct_month, month];
            dct_qual_list = dct_map(num2str(month));
            dct_month_quality = [dct_month_quality, mean(dct_qual_list)];
        end
        
        if isKey(wavelet_map, num2str(month))
            wavelet_month = [wavelet_month, month];
            wavelet_qual_list = wavelet_map(num2str(month));
            wavelet_month_quality = [wavelet_month_quality, mean(wavelet_qual_list)];
        end
        
        if isKey(tri1_map, num2str(month))
            tri1_month = [tri1_month, month];
            tri1_qual_list = tri1_map(num2str(month));
            tri1_month_quality = [tri1_month_quality, mean(tri1_qual_list)];
        end
        
        if isKey(tri2_map, num2str(month))
            tri2_month = [tri2_month, month];
            tri2_qual_list = tri2_map(num2str(month));
            tri2_month_quality = [tri2_month_quality, mean(tri2_qual_list)];
        end
    end
    
    plot(dct_month, dct_month_quality, '.');
    plot(wavelet_month, wavelet_month_quality, 'x');
    plot(tri1_month, tri1_month_quality, 'o');
    plot(tri2_month, tri2_month_quality, '*');
    %   plot(jpeg_size, jpeg_quality, '+');
    hold off
    legend('DCT','Wavelet','Tri1','Tri2')
    
end
if 1
    load('maps2/dct_map.mat');
    load('maps2/wavelet_map.mat');
    load('maps2/tri1_map.mat');
    load('maps2/tri2_map.mat');
    dct_map1 = dct_map;
    wavelet_map1 = wavelet_map;
    tri1_map1 = tri1_map;
    tri2_map1 = tri2_map;
    
    load('maps2/dct_map2.mat');
    load('maps2/wavelet_map2.mat');
    load('maps2/tri1_map2.mat');
    load('maps2/tri2_map2.mat');
    dct_map2 = dct_map;
    wavelet_map2 = wavelet_map;
    tri1_map2 = tri1_map;
    tri2_map2 = tri2_map;
    
    load('maps2/dct_map3.mat');
    load('maps2/wavelet_map3.mat');
    load('maps2/tri1_map3.mat');
    load('maps2/tri2_map3.mat');
    dct_map3 = dct_map;
    wavelet_map3= wavelet_map;
    tri1_map3 = tri1_map;
    tri2_map3 = tri2_map;
    
    quality1 = []
    month1 = []
    
    quality2 = []
    month2 = []
    
    quality3 = []
    month3 = []
    
    
    months = [ 62    60    58    56    54    51    49    46    44    41    38    35    32 28    25    21    18    14    12     9     7     5];
    for m = months
        curr_lst1 = [];
        if isKey(dct_map1, num2str(m))
            curr_lst1 = [curr_lst1, dct_map1(num2str(m))];
        end
        if isKey(wavelet_map1, num2str(m))
            curr_lst1 = [curr_lst1, wavelet_map1(num2str(m))];
        end
        if isKey(tri1_map1, num2str(m))
            curr_lst1 = [curr_lst1, tri1_map1(num2str(m))];
        end
        if isKey(tri2_map1, num2str(m))
            curr_lst1 = [curr_lst1, tri2_map1(num2str(m))];
        end
        if length(curr_lst1) > 0
            month1 = [month1, m];
            quality1 = [quality1 max(curr_lst1)];
        end
        
        curr_lst2 = [];
        if isKey(dct_map2, num2str(m))
            curr_lst2 = [curr_lst2, dct_map2(num2str(m))];
        end
        if isKey(wavelet_map2, num2str(m))
            curr_lst2 = [curr_lst2, wavelet_map2(num2str(m))];
        end
        if isKey(tri1_map2, num2str(m))
            curr_lst2 = [curr_lst2, tri1_map2(num2str(m))];
        end
        if isKey(tri2_map2, num2str(m))
            curr_lst2 = [curr_lst2, tri2_map2(num2str(m))];
        end
        if length(curr_lst2) > 0
            month2 = [month2, m];
            quality2 = [quality2 max(curr_lst2)];
        end
        
        curr_lst3 = [];
        if isKey(dct_map3, num2str(m))
            curr_lst3 = [curr_lst3, dct_map3(num2str(m))];
        end
        if isKey(wavelet_map3, num2str(m))
            curr_lst3 = [curr_lst3, wavelet_map3(num2str(m))];
        end
        if isKey(tri1_map3, num2str(m))
            curr_lst3 = [curr_lst3, tri1_map3(num2str(m))];
        end
        if isKey(tri2_map3, num2str(m))
            curr_lst3 = [curr_lst3, tri2_map3(num2str(m))];
        end
        if length(curr_lst3) > 0
            month3 = [month3, m]
            quality3 = [quality3 max(curr_lst3)]
        end
    end
    
    
    quality1 = [0.4486 0.4683 0.4883 0.6248 0.6777 0.6895 0.6895 0.6895 0.6895 0.6895];
    month1 = [32 28 25 21 18 14 12 9 7 5];
    quality2 = [0.4431 0.4486 0.4683 0.4683 0.4683 0.4883 0.4915 0.6248 0.6248  0.6777 0.6818 0.6895 0.6895 0.6895 0.6895 0.6895 0.6895 0.6895 0.6895];
    month2 = [56 54 51 49 46 44 41 38 35 32 28 25 21 18 14 12 9 7 5];
    quality3 =  [0.4683    0.4683    0.4883     0.4883 0.6092    0.6248    0.6248    0.6248 0.6777    0.6814    0.6892    0.6895    0.6895 0.6895  0.6895 0.6895 0.6895 0.6895 0.6895 0.6895 0.6895 0.6895];
    month3 = [62    60    58    56    54    51    49    46    44    41    38    35    32 28    25    21    18    14    12     9     7     5];
    figure
    hold on
    plot(month1, quality1, '');
    plot(month2, quality2, '-x');
    plot(month3, quality3, '-o');
    %   plot(jpeg_size, jpeg_quality, '+');
    hold off
    legend('1', '2', '3')
    
    
end