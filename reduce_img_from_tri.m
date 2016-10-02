% given the input image and triangularization, color each triangle with the
% average intensity, and generate a new image, also outputs the bitlength
% for encoding this image
% assumption: img size 64 x 64

function [ result_img, bitlength ] = reduce_img_from_tri( img, tri )
 figure
    h2 = imshow(imresize(rgb2gray(img),[64,64]));
    ax2 = ancestor(h2, 'axes');
    ax2.Visible = 'on';
    hold(ax2, 'on');
    triplot(tri, 'w', 'Parent', ax2);
  conn_list = tri.ConnectivityList;
  number_of_tris = size(conn_list, 1);
  points = tri.Points;
for i = 1:number_of_tris
    curr_tri = conn_list(i,:);
    pts = [points(curr_tri(1),:); points(curr_tri(2),:); points(curr_tri(3),:)];
    color = rand(1,3); % TODO: replace by the average color / intensity inside that triangle
    patch(pts(:,1), pts(:,2), color);
end
result_img = [];
bitlength = 0;

end

