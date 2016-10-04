
function [erode_map, dilate_map, result_map] = refine_combined_maps(input_map, watershed_map, foreground_color)
se = strel('disk', 5);
se2 = strel('disk', 10);
input_map = bwareaopen(input_map,1000);

% erosion
erode_map = imerode(input_map, se);
% dilation
dilate_map = imdilate(erode_map, se2);

graywatershed_map = rgb2gray(watershed_map);
map_size = size(graywatershed_map);
w = map_size(2);
h = map_size(1);

result_map = zeros(map_size);
for x = 1:w
    for y = 1:h
        if ismember(graywatershed_map(y,x), foreground_color) && dilate_map(y,x) > 0
            result_map(y,x) = 255; 
        end
    end
end


% remove small parts
%result_map = bwareaopen(dilate_map,50);