function [ result_img, bitlength ] = reduce_img_from_tri_texture( img, tri, texture_num )
% figure
h2 = imshow(imresize(rgb2gray(img),[64,64]));
ax2 = ancestor(h2, 'axes');
ax2.Visible = 'on';
hold(ax2, 'on');
triplot(tri, 'w', 'Parent', ax2);
conn_list = tri.ConnectivityList;
number_of_tris = size(conn_list, 1);
points = tri.Points;
textures = zeros(64,number_of_tris);
for i = 1:number_of_tris
    curr_tri = conn_list(i,:);
    pts = [points(curr_tri(1),:); points(curr_tri(2),:); points(curr_tri(3),:)];
    % color = rand(1,3); % TODO: replace by the average color / intensity inside that triangle
    % approach: find 2 textures that best represent the triangles
    % assign texture to each triangle
    texture = average_texture(img, pts);
    textures(:,i) = texture(:);
end

[mean_texture, texture_index] = get_mean_texture(textures, texture_num);
patch_texture(conn_list, points, mean_texture, texture_index)
%for i = 1:number_of_tris
%    curr_tri = conn_list(i,:);
%    pts = [points(curr_tri(1),:); points(curr_tri(2),:); points(curr_tri(3),:)];
    % TODO: implement patch_texture()
    
%    patch_texture(pts(:,1), pts(:,2), mean_texture, texture_index);
%end
result_img = [];
bitlength = 0;


end

