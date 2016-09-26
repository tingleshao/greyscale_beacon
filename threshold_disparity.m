% convert a depth map into binary map based on some hard-coded threshold 
function [ binary_disparity ] = threshold_disparity( disparity_map )
   threshold = 100;
   binary_disparity = disparity_map;
   binary_disparity(bianry_disparity > threshold) = 255;
   binary_disparity(bianry_dispairty <= threshold) = 0;
end

