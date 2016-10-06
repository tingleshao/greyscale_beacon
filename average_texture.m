function [ avgtexture ] = average_texture(img, pts)
addpath(genpath('poly_stuff/'));
% make the image to be 64 x 64 
curr_img = imresize(img, [64,64]);
ps = [];
for x = 1:64
    for y = 1:64
        
        ps = [ps; [x,y]];
    end
end
[in, on] = inpoly(ps, pts);
color = [];
psps = [];
for i = 1:64*64
    if in(i)
        x = idivide(uint32(i),uint32(64)) + 1;
        y = mod((i-1), 64) + 1;
        psps = [psps; [x, y]];
        color = [color; curr_img(y,x,:)];
    end
end
avgtexture = triangle2square(pts, psps, color);
end

