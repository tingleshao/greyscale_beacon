
%pts(:,1), pts(:,2), mean_texture, texture_index
function [ ] = patch_texture( conn_list, points, mean_texture, texture_index )
% draws patch inside this triangle

% canvas
canvas = zeros(64,64);
% for each texture in mean_texture, take half and affine transform it to
% the triangle and add to the canvas
for w = size(conn_list,1);
    tri = conn_list(w,:);
    point1 = points(tri(1),:);
    point2 = points(tri(2),:);
    point3 = points(tri(3),:);
    tri1 = [[point1 0]; [point2 0]; [point3 0]];
      % tri2: 3 by 2 matrix '
    tri2 = [1,1; 8,1; 1,8];
    T = maketform('affine',tri2,tri1); % TODO: may change to the recommended function later 
    transformed_pts = [];
    
    % get transformed pts
    x = 1;
    for i = 1:8
        for j = i:8
            pt = [i,j]; 
            transformed_pts = [transformed_pts; tformfwd(pt,T)];
            x = x+1;
        end
    end
    x = 1;
    texture = mean_texture(:, texture_index(w));
    texturer = reshape(texture(1:64), [8,8]);
    textureg = reshape(texture(65:128), [8,8]);
    textureb = reshape(texture(129:192), [8,8]);
    end
    for i = 1:64
        for j = i:64
            pt = transformed_pts(x);
            canvas(pt(2),pt(1),1) = texturer(j,i);
            canvas(pt(2),pt(1),2) = textureg(j,i);
            canvas(pt(2),pt(1),3) = textureb(j,i);
        end
    end
    imshow(canvas)
end


