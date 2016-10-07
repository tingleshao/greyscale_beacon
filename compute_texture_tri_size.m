function [ bits, raw_bits ] = compute_texture_tri_size( tri, img)
background = imresize(img, [3,3]);
addpath(genpath('encoder/'));
raw_bits = length(int8([tri.Points(:); tri.ConnectivityList(:)])) + size(tri.Points,1);
bits = length(gzipencode(int8([tri.Points(:); tri.ConnectivityList(:)]))) + size(tri.Points,1) + length(imencode(background));

end

