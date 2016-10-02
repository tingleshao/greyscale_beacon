% assumption: image size 64 x 64
function [  ] = plot_img_with_tri( img, tri )

if size(img,3) == 3
    h2 = imshow(imresize(rgb2gray(img),[64,64]));
else
    h2 = imshow(imresize(img, [64,64]));
end
ax2 = ancestor(h2, 'axes');
ax2.Visible = 'on';
hold(ax2, 'on');
triplot(tri, 'w', 'Parent', ax2);

end

