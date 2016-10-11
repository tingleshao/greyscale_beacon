clear
close all

% process data
process_data = 0

img_base = 'imu_data/';
if process_data
    % similar things as test 1
    data_ids = 0:11;
    data_f0 = [[179 0]; [179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0]];
    data_f1 = [[29 151]; [29 151];[29 151];[29 151];[29 151];[29 151];[29 151];[29 151];[29 151];[29 151];[29 151]];
    data_f2 = [[179 29]; [179 29];[179 29];[179 29];[179 29];[179 29];[179 29];[179 29];[179 29];[179 29];[179 29]];
    data_f3 = [[29 226]; [29 226];[29 226];[29 226];[29 226];[29 226];[29 226];[29 226];[29 226];[29 226];[29 226]];
    data_f4 = [[179 29]; [179 29];[179 29];[179 29];[179 29];[179 29];[179 29];[179 29];[179 29];[179 29];[179 29]];
    data_f5 = [[226 0]; [226 0];[226 0];[226 0];[226 0];[226 0];[226 0];[226 0];[226 0];[226 0];[226 0]];
    data_f6 = [[226 76]; [226 76];[226 76];[226 76];[226 76];[226 76];[226 76];[226 76];[226 76];[226 76];[226 76]];
    data_f7 = [[29 0]; [29 0];[29 0];[29 0];[29 0];[29 0];[29 0];[29 0];[29 0];[29 0];[29 0]];
    data_f8 = [[179 0]; [179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0]];
    data_f9 = [[179 0]; [179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0]];
    data_f10 = [[226 29]; [226 29];[226 29];[226 29];[226 29];[226 29];[226 29];[226 29];[226 29];[226 29];[226 29]];
    data_f11 = [[179 0]; [179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0]];
    data_f12 = [[179 0]; [179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0]];
    do_data = [0; 0; 0; 0; 0; 0; 1; 1; 0; 0; 1; 0; 0];
    
    for i = data_ids
        if do_data(i+1);
            data_dir = [img_base, 'set', num2str(i), '/'];
            img_dir = [data_dir, 'imgs/'];
            gc = imread([img_dir, 'gc.png']);
            %      gc = imresize(gc,[64,64]);
            gc(gc<10) = 0;
            gc(gc>0) = 1;
            % segment each pair of image
            left_img = imresize(imread([img_dir, 'im0.jpg']), [288,288]);
            eval(['current_dataf = data_f', num2str(i)]);
            Lrgb = watershed_img(left_img);
            for k = 1:10
                right_img = imresize(imread([img_dir, 'im', num2str(k), '.jpg']), [288,288]);
                [disparity_map1, foo] = compute_disparity(left_img, right_img);
                foreground_color = current_dataf(k,:);
                result_map = combine_two_maps(disparity_map1, Lrgb, foreground_color);
                [e_map, d_map, final_map] = refine_combined_maps(result_map, Lrgb, foreground_color);
                imwrite(left_img, [img_dir, 'segs', num2str(k), '/img_left.png']);
                imwrite(disparity_map1, [img_dir, 'segs', num2str(k), '/disparity_map1.png']);
                imwrite(Lrgb, [img_dir, 'segs', num2str(k), '/Lrgb.png']);
                imwrite(result_map, [img_dir, 'segs', num2str(k), '/result_map.png']);
                imwrite(final_map, [img_dir, 'segs', num2str(k), '/final_map.png']);
            end
        end
    end
end

evaluate_segs = 1
if evaluate_segs
    data_ids = 0:11;
    for i = data_ids
        i
        diff_lst = [];
        data_dir = [img_base, 'set', num2str(i), '/'];
        img_dir = [data_dir, 'imgs/'];
        gc = rgb2gray(imread([img_dir, 'gc.png']));
        gc(gc<100) = 0;
        gc(gc>0) = 255;
        figure;
        subplot(3,5,1)
        imshow(gc);
        
        for k = 1:10
            k
            segs_dir = [img_dir, '/segs', num2str(k), '/'];
            subplot(3,5,k+1)
            seg = imread([segs_dir, 'final_map.png']);
            imshow(seg)
            diffs = sum(sum(gc~=seg));
            sames = sum(sum(gc==seg));
         %   relative_diffs = diffs/sum(sum(gc==255))
            rocs = sames/diffs;
            title(num2str(rocs));
            diff_lst = [diff_lst; rocs];
        end
        save([img_dir, 'diffs_final.mat'], 'diff_lst');
    end
end

% read sensor data

read_sensor_data = 0
if read_sensor_data
    data_ids = 0:11;
    % start from 0
    % read training data
    training_do = [0; 1; 0; 1; 0; 1; 0; 1; 1; 0; 0; 0];
    w = 1;
    training_values = [];
    for i = data_ids 
        if training_do(i+1)
           data_dir = [img_base, 'set', num2str(i), '/'];
           files = dir(data_dir);
           filenames = {files.name}';
           for k = 1:length(filenames)
               filename = filenames{k};
               if length(strsplit(filename, 'r')) == 3 %good file to read
                   [dx, dy, dz, ax, ay, az] = textread([data_dir,filename], '%f,%f,%f,%f,%f,%f', 1);
                   training_data(w,:) = [dx, dy, dz, ax, ay, ax];
                   w = w + 1;
               end
           end
           load([data_dir, '/imgs/diffs_final.mat']); % get diff_lst
           training_values = [training_values; diff_lst];
        end
    end
    u = 1;
    test_do = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 1];
    testing_values  = [];

    for i = data_ids 
        if test_do(i+1)
           data_dir = [img_base, 'set', num2str(i), '/'];
           files = dir(data_dir);
           filenames = {files.name}';
           for k = 1:length(filenames)
               filename = filenames{k};
               if length(strsplit(filename, 'r')) == 3 %good file to read
                   [dx, dy, dz, ax, ay, az] = textread([data_dir,filename], '%f,%f,%f,%f,%f,%f', 1);
                   testing_data(u,:) = [dx, dy, dz, ax, ay, ax];
                   u = u + 1;
               end
           end
           load([data_dir, '/imgs/diffs_final.mat']); % get diff_lst
           testing_values = [testing_values; diff_lst];
        end
    end
end
'training'
Mdl = fitrtree(training_data, training_values);

% train/evaluate model
sensor_do = [0; 1; 0; 1; 0; 1; 0; 1; 1; 0; 0; 1];
