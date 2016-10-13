% test effect of different image types
clear
close all
signs_dir = 'imgs/disparity/test_image/signs/';
indoors_dir = 'imgs/disparity/test_image/near_indoor_objs/';
outdoors_dir = 'imgs/disparity/test_image/near_indoor_objs/';
buildings_dir = 'imgs/disparity/test_image/buildings/';
signs_set_lst = [1 2 3 4 5 6 7 8 9 11 13 14 15 16 18 19];
buildings_set_lst = [1 3];
near_indoor_set_lst = [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14];
near_outdoor_set_lst = [0 1];

signs_dct_map = containers.Map;
signs_wavelet_map = containers.Map;
signs_tri1_map = containers.Map;
signs_tri2_map = containers.Map;

buildings_dct_map = containers.Map;
buildings_wavelet_map = containers.Map;
buildings_tri1_map = containers.Map;
buildings_tri2_map = containers.Map;

indoor_dct_map = containers.Map;
indoor_wavelet_map = containers.Map;
indoor_tri1_map = containers.Map;
indoor_tri2_map = containers.Map;

outdoor_dct_map = containers.Map;
outdoor_wavelet_map = containers.Map;
outdoor_tri1_map = containers.Map;
outdoor_tri2_map = containers.Map;

[data_volume, battery_life] = volume_for_beacons_and_time(1, 0.5);

do_dct = 1
do_indoor = 1
do_outdoor = 1
do_buildings = 1

if do_dct
    for i = signs_set_lst
        dct_dir = [signs_dir, 'set', num2str(i), '/jpeg_res/'];
        wavelet_dir = [signs_dir, 'set', num2str(i), '/wavelet_res/']
        %  tri1_dir = [signs_dir, 'set', num2str(i), '/tri1_res/']
        %  tri2_dir = [signs_dir, 'set', num2str(i), '/tri2_res/']
        
        orig_img_dir = [signs_dir, 'set', num2str(i), '/segs/img_left.png']
        orig_img = imresize(imread(orig_img_dir),[64,64]);
        
        [dct_img, signs_dct_size] = read_images_in_dir( dct_dir );
        signs_dct_quality = compute_image_quality(dct_img, orig_img);
        for j = 1:length(signs_dct_size)
            curr_size = signs_dct_size(j);
            curr_quality = signs_dct_quality(j);
            for k = 1:length(data_volume)
                curr_dv = data_volume(k);
                curr_month = battery_life(k);
                if curr_size <= curr_dv
                    if isKey(signs_dct_map, num2str(curr_month))
                        quality_lst = signs_dct_map(num2str(curr_month));
                        signs_dct_map(num2str(curr_month)) = [quality_lst, curr_quality];
                    else
                        signs_dct_map(num2str(curr_month)) = [curr_quality];
                    end
                    break
                end
            end
        end
        
        [wavelet_img, signs_wavelet_size] = read_images_in_dir( wavelet_dir );
        signs_wavelet_quality = compute_image_quality(wavelet_img, orig_img);
        for j = 1:length(signs_wavelet_size)
            curr_size = signs_wavelet_size(j);
            curr_quality = signs_wavelet_quality(j);
            for k = 1:length(data_volume)
                curr_dv = data_volume(k);
                curr_month = battery_life(k);
                if curr_size <= curr_dv
                    if isKey(signs_wavelet_map, num2str(curr_month))
                        quality_lst = signs_wavelet_map(num2str(curr_month));
                        signs_wavelet_map(num2str(curr_month)) = [quality_lst, curr_quality];
                    else
                        signs_wavelet_map(num2str(curr_month)) = [curr_quality];
                    end
                    break
                end
            end
        end
        
        %     [tri1_img, tri1_size] = read_images_in_dir( tri1_dir );
        %     tri1_quality = compute_image_quality(tri1_img, orig_img);
        %     for j = 1:length(tri1_size)
        %         curr_size = tri1_size(j);
        %         curr_quality = tri1_quality(j);
        %         for k = 1:length(data_volume)
        %             curr_dv = data_volume(k);
        %             curr_month = battery_life(k);
        %             if curr_size <= curr_dv
        %                 if isKey(tri1_map, num2str(curr_month))
        %                     quality_lst = tri1_map(num2str(curr_month));
        %                     tri1_map(num2str(curr_month)) = [quality_lst, curr_quality];
        %                 else
        %                     tri1_map(num2str(curr_month)) = [curr_quality];
        %                 end
        %                 break
        %             end
        %         end
        %     end
        % %
        %     [tri2_img, tri2_size] = read_images_in_dir( tri2_dir );
        %     tri2_quality = compute_image_quality(tri2_img, orig_img);
        %     for j = 1:length(tri2_size)
        %         curr_size = tri2_size(j);
        %         curr_quality = tri2_quality(j);
        %         for k = 1:length(data_volume)
        %             curr_dv = data_volume(k);
        %             curr_month = battery_life(k);
        %             if curr_size <= curr_dv
        %                 if isKey(tri2_map, num2str(curr_month))
        %                     quality_lst = tri2_map(num2str(curr_month));
        %                     tri2_map(num2str(curr_month)) = [quality_lst, curr_quality];
        %                 else
        %                     tri2_map(num2str(curr_month)) = [curr_quality];
        %                 end
        %                 break
        %             end
        %         end
        %     end
        %
        % [tri1_img, tri3_size] = read_images_in_dir( tri3_dir );
        % tri3_quality = compute_image_quality(tri1_img, orig_img);
        
        %     [jpeg_img, jpeg_size] = read_jpeg_images_in_dir( jpeg_dir );
        %     jpeg_quality = compute_image_quality(jpeg_img, orig_img);
        
        % [jp2k_img, jp2k_size] = read_images_in_dir( jp2k_dir );
        % jp2k_quality = compute_image_quality(tri1_img, orig_img);
    end
end

if do_buildings
    for i = buildings_set_lst
        dct_dir = [buildings_dir, 'set', num2str(i), '/jpeg_res/'];
        wavelet_dir = [buildings_dir, 'set', num2str(i), '/wavelet_res/']
        %  tri1_dir = [signs_dir, 'set', num2str(i), '/tri1_res/']
        %  tri2_dir = [signs_dir, 'set', num2str(i), '/tri2_res/']
        %  tri3_dir = [signs_dir, 'set', num2str(i), '/tri3_res/']
        
        orig_img_dir = [buildings_dir, 'set', num2str(i), '/segs/img_left.png']
        orig_img = imresize(imread(orig_img_dir),[64,64]);
        
        [dct_img, buildings_dct_size] = read_images_in_dir( dct_dir );
        buildings_dct_quality = compute_image_quality(dct_img, orig_img);
        for j = 1:length(buildings_dct_size)
            curr_size = buildings_dct_size(j);
            curr_quality = buildings_dct_quality(j);
            for k = 1:length(data_volume)
                curr_dv = data_volume(k);
                curr_month = battery_life(k);
                if curr_size <= curr_dv
                    if isKey(buildings_dct_map, num2str(curr_month))
                        quality_lst = builidngs_dct_map(num2str(curr_month));
                        builidngs_dct_map(num2str(curr_month)) = [quality_lst, curr_quality];
                    else
                        builidngs_dct_map(num2str(curr_month)) = [curr_quality];
                    end
                    break
                end
            end
        end
        
        [wavelet_img, buildings_wavelet_size] = read_images_in_dir( wavelet_dir );
        buildings_wavelet_quality = compute_image_quality(wavelet_img, orig_img);
        for j = 1:length(buildings_wavelet_size)
            curr_size = buildings_wavelet_size(j);
            curr_quality = buildings_wavelet_quality(j);
            for k = 1:length(data_volume)
                curr_dv = data_volume(k);
                curr_month = battery_life(k);
                if curr_size <= curr_dv
                    if isKey(buildings_wavelet_map, num2str(curr_month))
                        quality_lst = buildings_wavelet_map(num2str(curr_month));
                        buildings_wavelet_map(num2str(curr_month)) = [quality_lst, curr_quality];
                    else
                        buildings_wavelet_map(num2str(curr_month)) = [curr_quality];
                    end
                    break
                end
            end
        end
    end
end

if do_indoor
    for i = near_indoor_set_lst
        dct_dir = [indoors_dir, 'set', num2str(i), '/jpeg_res/'];
        wavelet_dir = [indoors_dir, 'set', num2str(i), '/wavelet_res/']
        %  tri1_dir = [signs_dir, 'set', num2str(i), '/tri1_res/']
        %  tri2_dir = [signs_dir, 'set', num2str(i), '/tri2_res/']
        %  tri3_dir = [signs_dir, 'set', num2str(i), '/tri3_res/']
        
        orig_img_dir = [indoors_dir, 'set', num2str(i), '/segs/img_left.png']
        orig_img = imresize(imread(orig_img_dir),[64,64]);
        
        [dct_img, indoor_dct_size] = read_images_in_dir( dct_dir );
        indoor_dct_quality = compute_image_quality(dct_img, orig_img);
        for j = 1:length(indoor_dct_size)
            curr_size = indoor_dct_size(j);
            curr_quality = indoor_dct_quality(j);
            for k = 1:length(data_volume)
                curr_dv = data_volume(k);
                curr_month = battery_life(k);
                if curr_size <= curr_dv
                    if isKey(indoor_dct_map, num2str(curr_month))
                        quality_lst = indoor_dct_map(num2str(curr_month));
                        indoor_dct_map(num2str(curr_month)) = [quality_lst, curr_quality];
                    else
                        indoor_dct_map(num2str(curr_month)) = [curr_quality];
                    end
                    break
                end
            end
        end
        
        [wavelet_img, indoor_wavelet_size] = read_images_in_dir( wavelet_dir );
        indoor_wavelet_quality = compute_image_quality(wavelet_img, orig_img);
        for j = 1:length(indoor_wavelet_size)
            curr_size = indoor_wavelet_size(j);
            curr_quality = indoor_wavelet_quality(j);
            for k = 1:length(data_volume)
                curr_dv = data_volume(k);
                curr_month = battery_life(k);
                if curr_size <= curr_dv
                    if isKey(indoor_wavelet_map, num2str(curr_month))
                        quality_lst = indoor_wavelet_map(num2str(curr_month));
                        indoor_wavelet_map(num2str(curr_month)) = [quality_lst, curr_quality];
                    else
                        indoor_wavelet_map(num2str(curr_month)) = [curr_quality];
                    end
                    break
                end
            end
        end
    end
end

if do_outdoor
    for i = near_outdoor_set_lst
        dct_dir = [outdoors_dir, 'set', num2str(i), '/jpeg_res/'];
        wavelet_dir = [outdoors_dir, 'set', num2str(i), '/wavelet_res/']
        %  tri1_dir = [signs_dir, 'set', num2str(i), '/tri1_res/']
        %  tri2_dir = [signs_dir, 'set', num2str(i), '/tri2_res/']
        %  tri3_dir = [signs_dir, 'set', num2str(i), '/tri3_res/']
        
        orig_img_dir = [outdoors_dir, 'set', num2str(i), '/segs/img_left.png']
        orig_img = imresize(imread(orig_img_dir),[64,64]);
        
        [dct_img, outdoor_dct_size] = read_images_in_dir( dct_dir );
        outdoor_dct_quality = compute_image_quality(dct_img, orig_img);
        for j = 1:length(outdoor_dct_size)
            curr_size = outdoor_dct_size(j);
            curr_quality = outdoor_dct_quality(j);
            for k = 1:length(data_volume)
                curr_dv = data_volume(k);
                curr_month = battery_life(k);
                if curr_size <= curr_dv
                    if isKey(outdoor_dct_map, num2str(curr_month))
                        quality_lst = outdoor_dct_map(num2str(curr_month));
                        outdoor_dct_map(num2str(curr_month)) = [quality_lst, curr_quality];
                    else
                        outdoor_dct_map(num2str(curr_month)) = [curr_quality];
                    end
                    break
                end
            end
        end
        
        [wavelet_img, outdoor_wavelet_size] = read_images_in_dir( wavelet_dir );
        outdoor_wavelet_quality = compute_image_quality(wavelet_img, orig_img);
        for j = 1:length(outdoor_wavelet_size)
            curr_size = outdoor_wavelet_size(j);
            curr_quality = outdoor_wavelet_quality(j);
            for k = 1:length(data_volume)
                curr_dv = data_volume(k);
                curr_month = battery_life(k);
                if curr_size <= curr_dv
                    if isKey(outdoor_wavelet_map, num2str(curr_month))
                        quality_lst = outdoor_wavelet_map(num2str(curr_month));
                        outdoor_wavelet_map(num2str(curr_month)) = [quality_lst, curr_quality];
                    else
                        outdoor_wavelet_map(num2str(curr_month)) = [curr_quality];
                    end
                    break
                end
            end
        end
    end
end


months = [62 60 58 56 54 51 49 46 44 41 38 35 32 28 25 21 18 14 12 9 7 5];
month_sign = [];
month_building = [];
month_indoor = [];
month_outdoor = [];
quality_sign = [];
quality_building = [];
quality_indoor = [];
quality_outdoor = [];

for m = months
    curr_lst = [];
    if isKey(signs_dct_map, num2str(m))
        curr_lst = [curr_lst, mean(signs_dct_map(num2str(m)))];
    end
    if isKey(signs_wavelet_map, num2str(m))
        curr_lst = [curr_lst, mean(signs_wavelet_map(num2str(m)))];
    end
 %   if isKey(tri1_map1, num2str(m))
 %       curr_lst1 = [curr_lst1, tri1_map1(num2str(m))];
 %   end
 %   if isKey(tri2_map1, num2str(m))
 %       curr_lst1 = [curr_lst1, tri2_map1(num2str(m))];
 %   end
    if length(curr_lst) > 0
        month_sign = [month_sign, m];
        quality_sign = [quality_sign max(curr_lst)];
    end
    
    curr_lst = [];
    if isKey(buildings_dct_map, num2str(m))
        curr_lst = [curr_lst, mean(buildings_dct_map(num2str(m)))];
    end
    if isKey(buildings_wavelet_map, num2str(m))
        curr_lst = [curr_lst, mean(buildings_wavelet_map(num2str(m)))];
    end
    if length(curr_lst) > 0
        month_building = [month_building, m];
        quality_building = [quality_building max(curr_lst)];
    end
    
    curr_lst = [];
    if isKey(outdoor_dct_map, num2str(m))
        curr_lst = [curr_lst, mean(outdoor_dct_map(num2str(m)))];
    end
    if isKey(outdoor_wavelet_map, num2str(m))
        curr_lst = [curr_lst, mean(outdoor_wavelet_map(num2str(m)))];
    end
    if length(curr_lst) > 0
        month_outdoor = [month_outdoor, m];
        quality_outdoor = [quality_outdoor max(curr_lst)];
    end
        
    curr_lst = [];
    if isKey(indoor_dct_map, num2str(m))
        curr_lst = [curr_lst, mean(indoor_dct_map(num2str(m)))];
    end
    if isKey(indoor_wavelet_map, num2str(m))
        curr_lst = [curr_lst, mean(indoor_wavelet_map(num2str(m)))];
    end
    if length(curr_lst) > 0
        month_indoor = [month_indoor, m];
        quality_indoor = [quality_indoor max(curr_lst)];
    end

end

% for i = length(quality_sign):-1:2
%     if quality_sign(i) < quality_sign(i-1)
%         quality_sign(i) = quality_sign(i-1);
%     end
% end
% 
% for i = length(quality_building):-1:2
%     if quality_building(i) < quality_building(i-1)
%         quality_building(i) = quality_building(i-1);
%     end
% end
% 
% for i = length(quality_indoor):-1:2
%     if quality_indoor(i) < quality_indoor(i-1)
%         quality_indoor(i) = quality_indoor(i-1);
%     end
% end
% 
% for i = length(quality_outdoor):-1:2
%     if quality_outdoor(i) < quality_outdoor(i-1)
%         quality_outdoor(i) = quality_outdoor(i-1);
%     end
% end
quality_sign = [0.3955    0.3955    0.3955    0.4255    0.4356    0.4356    0.4356    0.4611]
quality_building = [0.4799    0.5825    0.6090    0.6345    0.6510    0.6660]
quality_indoor = [0.5335    0.5445    0.5445    0.5490    0.5534    0.5590    0.5590]
quality_outdoor = [ 0.6186    0.6223    0.6225    0.6225    0.6247    0.6270]
        figure
    hold on
    plot(month_sign, quality_sign, '-.');
    plot(month_building, quality_building, '-x');
    plot(month_outdoor, quality_outdoor, '-o');
    plot(month_indoor, quality_indoor, '-+');
    hold off
    legend('sign', 'building', 'indoor', 'outdoor')

