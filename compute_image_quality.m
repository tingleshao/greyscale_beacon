function [ quality_list ] = compute_image_quality( input_imgs, original_img )
% input_img: 64 x64 x 3 x k 
% compute ssim on each channel 

quality_list = [];
for k = 1: size(input_imgs, 4)
%ssimr = ssim(input_imgs(:,:,1,k), original_img(:,:,1));
%ssimg = ssim(input_imgs(:,:,2,k), original_img(:,:,2));
%ssimb = ssim(input_imgs(:,:,3,k), original_img(:,:,3));
ssimres = ssim(input_imgs(:,:,:,k), original_img);
quality_list = [quality_list; ssimres];

end

