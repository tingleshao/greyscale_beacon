% give a set of textures(64*3, n);
% TODO: change the problem in average_texture;
% derive 1 mean or two means
function [ mean_texture, texture_index ] = get_mean_texture( textures, texture_num )

if texture_num == 1
    mean_texture = mean(textures, 2);
    texture_index = ones(size(textures,2));
elseif texture_num == 2
    % if want two classes, do k-means
    [idx, mean_texture] = kmeans(textures', 2);
    mean_texture = mean_texture';
    texture_index = idx;
end

end

