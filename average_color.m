% 

function [ avgcolor ] = average_color( img, pts )
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
for i = 1:64*64
    if on(i)
        x = idivide(uint32(i),uint32(64)) + 1;
        y = mod((i-1), 64) + 1;
        color = [color; curr_img(y,x,:)];
    end
end
avgcolor = mean(color, 1) / 255



end

