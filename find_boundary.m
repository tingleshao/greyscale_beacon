% input image suppose to be binary image
function [ boundary_img ] = find_boundary( input_img )
input_img_erode = imerode(input_img,strel('disk',1)); %# mask all but the border
boundary_img = input_img - input_img_erode;
end

