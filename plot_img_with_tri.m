% assumption: image size 64 x 64 
function [  ] = plot_img_with_tri( img, tri )

h2 = imshow(imresize(rgb2gray(img),[64,64]));
ax2 = ancestor(h2, 'axes');
ax2.Visible = 'on';
hold(ax2, 'on');
triplot(tri, 'w', 'Parent', ax2);

end

