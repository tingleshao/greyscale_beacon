function [ result_map ] = combine_two_maps( depth_map, watershed_map, foreground_color )
% use high threshold to know which seg part is foreground
watershed_map = rgb2gray(watershed_map);
% foreground: 29
threshold = 4;
map_size = size(depth_map);
w = map_size(2);
h = map_size(1);

result_map = zeros(map_size);
for x = 1:w
    for y = 1:h
        if ismember(watershed_map(y,x),foreground_color) && depth_map(y,x) > threshold
            result_map(y,x) = 255; 
        end
    end
end
% lower the threshold and over lay with foreground part to get the
% foreground map
% (optional)grow the map to the boundary of the watershed map 
% return the map

end

