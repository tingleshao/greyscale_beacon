function [ bits, raw_bits ] = compute_tri_size( tri )
addpath(genpath('encoder/'));
raw_bits = length(int8([tri.Points(:); tri.ConnectivityList(:)])) + size(tri.Points,1);
bits = length(gzipencode(int8([tri.Points(:); tri.ConnectivityList(:)]))) + size(tri.Points,1);



end

