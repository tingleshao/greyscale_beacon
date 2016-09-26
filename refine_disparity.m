% refine the bianry_disparity map with some morphological operations 
function [refined_disparity] = refine_disparity(binary_dis) 
% default connected componenets: 8 
    refined_disparity = bwareaopen(binary_dis);
    
    
    