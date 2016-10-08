function [ result_img, bitlength ] = reduce_img_from_tri_texture( img, tri, texture_num, work_dir )
% figure
h2 = imshow(zeros(64,64));
ax2 = ancestor(h2, 'axes');
ax2.Visible = 'on';
hold(ax2, 'on');
conn_list = tri.ConnectivityList;
number_of_tris = size(conn_list, 1);
points = tri.Points;
textures = zeros(64*3,number_of_tris);
for i = 1:number_of_tris
    curr_tri = conn_list(i,:);
    pts = [points(curr_tri(1),:); points(curr_tri(2),:); points(curr_tri(3),:)];
    % color = rand(1,3); % TODO: replace by the average color / intensity inside that triangle
    % approach: find 2 textures that best represent the triangles
    % assign texture to each triangle
    texture = average_texture(img, pts);
    texturer = texture(:,:,1);
    textureg = texture(:,:,2);
    textureb = texture(:,:,3);
    textures(1:64,i) = texturer(:);
    textures(65:128,i) = textureg(:);
    textures(129:192,i) = textureb(:);
end

[mean_texture, texture_index] = get_mean_texture(textures, texture_num);
mean_img(:,:,1) = reshape(mean_texture(1:64,1),[8,8]);
mean_img(:,:,2) = reshape(mean_texture(65:128,1),[8,8]);
mean_img(:,:,3) = reshape(mean_texture(129:192,1),[8,8]);
%figure;
%imshow(mean_img)
%figure;
%figure;
%imshow(mean_img/255)
canvas = patch_texture(img, conn_list, points, mean_texture, texture_index);
%for i = 1:number_of_tris
%    curr_tri = conn_list(i,:);
%    pts = [points(curr_tri(1),:); points(curr_tri(2),:); points(curr_tri(3),:)];
    % TODO: implement patch_texture()
%    patch_texture(pts(:,1), pts(:,2), mean_texture, texture_index);
%end
imshow(canvas)
result_img = canvas/255;
bitlength = 0;
%triplot(tri, 'w', 'Parent', ax2);
imagesize = compute_texture_tri_size(tri, mean_texture, img);
title(num2str(imagesize))
imwrite(canvas, [work_dir, 'tri2_res/numtri_', num2str(number_of_tris), '_size_', num2str(imagesize), '.png']);


end

