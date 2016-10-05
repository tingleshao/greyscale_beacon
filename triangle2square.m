function [ square_img ] = triangle2square( tri1, list_of_pts, list_of_intensity )
    % list of intensity: n x 3 with every row a color rgb pixel value
    % tri1: 3 by 2 matrix
    % tri2: 3 by 2 matrix '
    tri2 = [1,1; 64,1; 1,64];
    T = maketform('affine',tri1,tri2); % TODO: may change to the recommended function later 
    transformed_pts = zeros(size(list_of_intensity,1) , 2);
    
    % get transformed pts
    x = 1;
    for pt = list_of_pts 
        transformed_pts(x,:) = tformfwd(pt,T);
        x = x+1;
    end
    
    % make a picture
    pic = zeros(64,64);
    x = 1;
    for pt = transformed_pts
        pic(pt(2), pt(1),:) = list_of_intensity(x,:);
        x = x+1;
    end
    pict = pic';
    final_pic = pict + pic;
    square_img  = imresize(final_pic, [8, 8]);
end

