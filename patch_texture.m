
%pts(:,1), pts(:,2), mean_texture, texture_index
function [ canvas] = patch_texture( orig_img, conn_list, points, mean_texture, texture_index )
% draws patch inside this triangle

background = imresize(imresize(orig_img,[3,3]),[64,64]);
% canvas
canvas = background;
% for each texture in mean_texture, take half and affine transform it to
% the triangle and add to the canvas
size(conn_list)

for w = 1:size(conn_list,1);
     
    tri = conn_list(w,:);
    point1 = points(tri(1),:);
    point2 = points(tri(2),:);
    point3 = points(tri(3),:);
    %   tri1 = [[point1 0]; [point2 0]; [point3 0]];
    tri1 = [point1; point2 ; point3 ];
    % tri2: 3 by 2 matrix '
    tri2 = [1,1; 8,1; 1,8];
    T = maketform('affine',tri2,tri1); % TODO: may change to the recommended function later
    transformed_pts = [];
    
    % get transformed pts
    x = 1;
    for i = 1:8
        for j = 1:8-i+1
            pt = [i,j];
            transformed_pts = [transformed_pts; tformfwd(pt,T)];
            x = x+1;
        end
    end
    %   texture = mean_texture(:, texture_index(w));
    texture = mean_texture(:, 1);
    
    texture_img(:,:,1) = reshape(texture(1:64), [8,8]);
    texture_img(:,:,2) = reshape(texture(65:128), [8,8]);
    texture_img(:,:,3) = reshape(texture(129:192), [8,8]);
    %  double(transformed_pts)
    %   end
    
    transformed_texture = imtransform(texture_img, T);
    
 %   figure;
%    imshow(transformed_texture/255);
    
    % fill the texture for current triangle
    ps = [];
    for x = 1:64
        for y = 1:64
            ps = [ps; [x,y]];
        end
    end
    [in, on] = inpoly(ps, tri1);
    ty = 1;
    tx = 1;
    gray_texture = rgb2gray(transformed_texture);
    while gray_texture(ty,tx,:) == 0
        ty = ty+1;
        if ty > size(transformed_texture, 1)
            ty = 1;
            tx = tx +1;
        end
        if tx > size(transformed_texture, 2)
            break;
        end
    end
    
    for i = 1:64*64
        if in(i)
            x = idivide(uint32(i),uint32(64)) + 1;
            y = mod((i-1), 64) + 1;
       %     ty
      %      tx
      %      size(transformed_texture)
            if tx > size(transformed_texture, 2)
               break
            end
            canvas(y,x,:) = transformed_texture(ty,tx,:);
            ty = ty+1;
            if ty > size(transformed_texture, 1)
                    ty = 1;
                    tx = tx +1;
            end
            if tx > size(transformed_texture, 2)
               break
            end
            while gray_texture(ty,tx,:) == 0
                ty = ty+1;
                if ty > size(transformed_texture, 1)
                    ty = 1;
                    tx = tx +1;
                end
                if tx > size(transformed_texture, 2)
                    break
                end
            end
        %    psps = [psps; [x, y]];
       %     color = [color; curr_img(y,x,:)];
        end
    end
end


