function [ bits, raw_bits ] = compute_texture_tri_size(tri, texture, img)
background = imresize(img, [3,3]);
real_texture = texture(texture>0);
addpath(genpath('encoder/'));
raw_bits = length(int8([tri.Points(:); tri.ConnectivityList(:)])) + size(tri.Points,1);
bits = length(gzipencode(int8([tri.Points(:); tri.ConnectivityList(:)]))) + length(gzipencode(int8([real_texture(:)]))) + length(imencode(background));
end

