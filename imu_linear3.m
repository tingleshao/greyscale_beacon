clear
close all

% process data
process_data = 0

img_base = 'imu_data2/';
if process_data
    % similar things as test 1
    data_ids = 0:32;
 %   do_data = [0; 0; 0; 0; 0; 0; 0; 0; 0; 1;
   %     1; 1; 1; 1; 1; 1; 1; 1; 1; 1;
  %      1; 0; 0; 0; 0; 0; 0; 0; 0; 0;
   %     0; 0; 0];
 %   do_data = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0;
  %      1; 1; 1; 1; 1; 1; 1; 1; 1; 1;
  %      1; 0; 0; 0; 0; 0; 0; 0; 0; 0;
  %      0; 0; 0];
    do_data = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0;
        0; 0; 1; 1; 1; 0; 1; 1; 1; 1;
        1; 0; 0; 0; 0; 0; 0; 0; 0; 0;
        0; 0; 0];
    do_data2 = [0; 0; 0; 0; 0; 0; 0; 1; 1; 0;
        0; 0; 0; 0; 0; 0; 0; 0; 0; 0;
        0; 1; 1; 0; 1; 1; 0; 1; 1; 1;
        1; 1; 1];
    data_f0 = [[76 29 226]; [76 29 226];[76 29 226];[76 29 226]];
    data_f1 = [[176 79 129 194 210 179 126 226]; [176 79 129 194 210 179 126 226];[176 79 129 194 210 179 126 226];[176 79 129 194 210 179 126 226]];
    data_f2 = [[179 29]; [179 29];[179 29];[179 29];[179 29];[179 29]];
    data_f3 = [[179 0]; [179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0]];
    data_f4 = [[29 0]; [29 0]];
    data_f5 = [[104 151 38 29]; [104 151 38 29];[104 151 38 29]];
    data_f6 = [[179 29 226]; [179 29 226];[179 29 226];[179 29 226]];
    
    data_f7 = [[179 0]; [179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0]];
    data_f8 = [[29 0]; [29 0];[29 0];[29 0];[29 0];[29 0]];
    
    data_f9 = [[179 0]; [179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0]];
    data_f10 = [[179 0]; [179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0]];
    data_f11 = [[179 0]; [179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0]];
    data_f12 = [[76 0]; [76 0];[76 0];[76 0];[76 0];[76 0];[76 0];[76 0];[76 0];[76 0];[76 0]];
    data_f13 = [[179 29]; [179 29];[179 29];[179 29];[179 29];[179 29];[179 29];[179 29];[179 29];[179 29];[179 29]];
    data_f14 = [[179 76]; [179 76];[179 76];[179 76];[179 76];[179 76];[179 76];[179 76];[179 76];[179 76];[179 76]];
    data_f15 = [[179 0]; [179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0]];
    data_f16 = [[104 151]; [104 151];[104 151];[104 151];[104 151];[104 151];[104 151];[104 151];[104 151];[104 151];[104 151]];
    data_f17 = [[179 203]; [179 203];[179 203];[179 203];[179 203];[179 203];[179 203];[179 203];[179 203];[179 203];[179 203]];
    data_f18 = [[29 0]; [29 0];[29 0];[29 0];[29 0];[29 0];[29 0];[29 0];[29 0];[29 0];[29 0]];
    data_f19 = [[203 0]; [203 0];[203 0];[203 0];[203 0];[203 0];[203 0];[203 0];[203 0];[203 0];[203 0]];
    data_f20 = [[76 0]; [76 0];[76 0];[76 0];[76 0];[76 0];[76 0];[76 0];[76 0];[76 0];[76 0]];
   
    data_f21 = [[29 0]; [29 0];[29 0];[29 0];[29 0];[29 0]];
    data_f22 = [[179 29]; [179 29];[179 29];[179 29];[179 29];[179 29];[179 29];[179 29];[179 29];[179 29];[179 29]];
    data_f23 = [[179 0]; [179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0]];
    data_f24 = [[76 0]; [76 0];[76 0];[76 0]];
    data_f25 = [[76 0]; [76 0];[76 0];[76 0];[76 0]; [76 0];[76 0];[76 0]];
    data_f26 = [[179 0]; [179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0]];
    data_f27 = [[76 0]; [76 0];[76 0];[76 0];[76 0]; [76 0];[76 0];[76 0]];
    data_f28 = [[226 0]; [226 0];[226 0];[226 0];[226 0];[226 0]];
    data_f29 = [[179 0]; [179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0]];
    data_f30 = [[179 0]; [179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0]];
    data_f31 = [[151 0]; [151 0];[151 0];[151 0];[151 0];[151 0]];
    data_f32 = [[179 0]; [179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0];[179 0]];
    
    
    %  do_data = [0; 0; 0; 0; 0; 0; 1; 1; 0; 0; 1; 0; 0];
    
    for i = data_ids
        if do_data(i+1);
            data_dir = [img_base, 'set', num2str(i), '/'];
            img_dir = [data_dir, 'imgs/'];
            %      gc = imread([img_dir, 'gc.png']);
            %      gc = imresize(gc,[64,64]);
            %      gc(gc<10) = 0;
            %      gc(gc>0) = 1;
            % segment each pair of image
            left_img = imresize(imread([img_dir, 'im0.jpg']), [288,288]);
            eval(['current_dataf = data_f', num2str(i)]);
            Lrgb = watershed_img(left_img);
            files = dir(img_dir);
            filenames = {files.name}';
            number_of_files = length(filenames);
            for k = 1:number_of_files
                filename = filenames{k}
                fnamesplit =  strsplit(filename, '.');
                if length(fnamesplit) > 1
                    ext = fnamesplit(2);
                    if strcmp(ext, 'jpg') && ~strcmp(fnamesplit{1}, 'im0')
                        imidsplit = strsplit(fnamesplit{1},'im');
                        imid = str2double(imidsplit{2})
                        right_img = imresize(imread([img_dir, filename]), [288,288]);
                        [disparity_map1, foo] = compute_disparity(left_img, right_img);
                        foreground_color = current_dataf(imid,:);
                        result_map = combine_two_maps(disparity_map1, Lrgb, foreground_color);
                        [e_map, d_map, final_map] = refine_combined_maps(result_map, Lrgb, foreground_color);
                        imwrite(left_img, [img_dir, 'segs', num2str(imid), '/img_left.png']);
                        imwrite(disparity_map1, [img_dir, 'segs', num2str(imid), '/disparity_map1.png']);
                        imwrite(Lrgb, [img_dir, 'segs', num2str(imid), '/Lrgb.png']);
                        imwrite(result_map, [img_dir, 'segs', num2str(imid), '/result_map.png']);
                        imwrite(final_map, [img_dir, 'segs', num2str(imid), '/final_map.png']);
                    end
                end
            end
        end
    end
end

evaluate_segs = 0
if evaluate_segs
    data_ids = 0:32;
 %   do_seg = [0; 0; 0; 0; 0; 0; 0; 1; 1; 0;
 %       0; 0; 0; 0; 0; 0; 0; 0; 0; 0;
  %     0; 1; 1; 0; 1; 1; 0; 1; 1; 1;
   %     1; 1; 1];
        do_seg = [0; 0; 0; 0; 0; 0; 0; 1; 1; 1;
        1; 1; 1; 1; 1; 1; 1; 1; 1; 1;
        1; 1; 1; 0; 1; 1; 1; 1; 1; 1;
        1; 1; 1];
    
    %  do_seg = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0;
    %     0; 0; 1; 1; 1; 1; 1; 1; 1; 1;
    %      0; 1; 1; 1; 1; 1; 1; 1; 1; 1;
    %      1];
    for i = data_ids
        i
        if do_seg(i+1)
            diff_lst = [];
            data_dir = [img_base, 'set', num2str(i), '/'];
            img_dir = [data_dir, 'imgs/'];
            gc = rgb2gray(imread([img_dir, 'gc.png']));
            gc(gc<100) = 0;
            gc(gc>0) = 255;
            figure;
            subplot(3,5,1)
            imshow(gc);
            files = dir(img_dir);
            filenames = {files.name}';
            number_of_files = length(filenames);
            for k = 1:number_of_files
                k
                filename = filenames{k}
                fnamesplit =  strsplit(filename, '.');
                if length(fnamesplit) > 1
                    ext = fnamesplit(2);
                    if strcmp(ext, 'jpg') && ~strcmp(fnamesplit{1}, 'im0')
                        imidsplit = strsplit(fnamesplit{1},'im');
                        imid = str2double(imidsplit{2})
                        
                        segs_dir = [img_dir, '/segs', num2str(imid), '/'];
                        subplot(3,6,k+1)
                        seg = imread([segs_dir, 'final_map.png']);
                        imshow(seg)
                        
                        
                        dintersection = sum(sum((gc==seg) .* (gc==255)));
                        dunionx = (seg==255) + (gc==255);
                        for x = 1:288
                            for y = 1:288
                                if dunionx(y,x) == 2
                                    dunionx(y,x) = 1;
                                end
                            end
                        end
                        dunion = sum(sum(dunionx));
                        %   relative_diffs = diffs/sum(sum(gc==255))
                        rocs = dintersection/dunion;
                        title(num2str(rocs));
                        diff_lst = [diff_lst; rocs];
                    end
                end
            end
            save([img_dir, 'diffs_final.mat'], 'diff_lst');
        end
    end
end

% read sensor data

read_sensor_data = 1
if read_sensor_data
    data_ids = 0:32;
    % start from 0
    % read training data
 %  training_do = [0; 1; 0; 1; 0; 1; 0; 1; 1; 0;
  %      0; 1; 1; 1; 0; 0; 1; 0; 0; 0;
   %     0; 0; 0; 1; 0; 0; 0; 0; 0; 0;
    %    0];
    
  
    
 %   training_do = [0; 0; 0; 0; 0; 0; 0; 1; 1; 0;
 %       0; 0; 0; 0; 0; 0; 0; 0; 0; 0;
  %      0; 1; 1; 0; 1; 1; 0; 0; 0; 0;
 %       0; 0; 0];
    
  %  training_do = [0; 0; 0; 0; 0; 0; 0; 0; 0; 1;
  %      1; 1; 1; 1; 1; 1; 1; 1; 1; 1;
  %      1; 0; 0; 0; 0; 0; 0; 0; 0; 0;
  %      0; 0; 0];
    
      training_do = [0; 0; 0; 0; 0; 0; 0; 0; 0; 1;
        0; 0; 1; 1; 1; 1; 0; 0; 0; 0;
        0; 0; 0; 0; 0; 0; 0; 0; 0; 0;
        0; 0; 0];
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
%   test_do = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0;
 %      0; 0; 0; 0; 0; 0; 0; 0; 0; 0;
  %      0; 0; 0; 0; 1; 1; 0; 0; 0; 0;
   %     1];
   
       test_do = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0;
        0; 0; 0; 0; 0; 0; 0; 1; 1; 1;
        1; 0; 0; 0; 0; 0; 0; 0; 0; 0;
        0; 0; 0];
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

train_model = 1
if train_model
    'training'
    Mdl = fitrtree(training_data, training_values);
    
    
% train/evaluate model
Ynew = predict(Mdl,testing_data)
plot(1:length(testing_values), testing_values,1:length(testing_values), Ynew)

legend('testing', 'Ynew')
    
end