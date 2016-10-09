function [ imgs, sizes ] = read_images_in_dir( input_dir )
% reads imasges in the given dir, returns imgs as 64*64*3*k array
% sizes is length k array, each element is the size from file name

a = dir(input_dir);
file_names = {a.name}';

k = 1;
imgs = [];
sizes = [];
length(file_names)
for i = 1:length(file_names)
    filename = file_names{i};
    b = length(filename);
    if length(filename) > 2
        filename_split = strsplit(filename, '.');
        ext = filename_split(length(filename_split));
        if strcmp(ext, 'png')
            img = imread([input_dir, filename]);
            imgs(:,:,:,k) = img;
            k = k + 1;
            filename_sizesplit = strsplit(filename, '_');
            size_part = filename_sizesplit{4};
            size_part_split = strsplit(size_part, '.');
            size_num = str2double(size_part_split{1});
            sizes = [sizes, size_num];
        end
    end
end
imgs = uint8(imgs);



end

