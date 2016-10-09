function [ imgs, sizes ] = read_jpeg_images_in_dir( input_dir )
% reads imasges in the given dir, returns imgs as 64*64*3*k array
% sizes is length k array, each element is the size from file name

a = dir(input_dir);
file_names = {a.name}';
file_sizes = {a.bytes}';

k = 1;
imgs = [];
sizes = [];
length(file_names)
for i = 1:length(file_names)
    filename = file_names{i};
    if length(filename) > 2
        filename_split = strsplit(filename, '.');
        ext = filename_split(length(filename_split));
        if strcmp(ext, 'jpg')
            img = imread([input_dir, filename]);
            imgs(:,:,:,k) = img;
            sizes = [sizes, file_sizes{i}];
            k = k+1;
        end
    end
    
end
imgs = uint8(imgs);

end

