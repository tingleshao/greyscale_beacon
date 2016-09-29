% convert a depth map into binary map based on some hard-coded threshold 
function [ binary_disparity ] = threshold_disparity( disparity_map )
   threshold = 4;
   binary_disparity = disparity_map;
   binary_disparity(binary_disparity > threshold) = 255;
   binary_disparity(binary_disparity <= threshold) = 0;
end

