% triangularize the input shape
% input shape: binary image: input_shape, 
% number of triangles: n
function [triangles] = triangularization(input_shape, n)
% step1: shape is in bianry image format, convert it into list of boundary
% points 
%  TODO: any optimizaed way to do this? 
  [x,y] = find_boundary(input_shape);
% step2: connect boundary points to form 
  triangles = delaunay(x,y);
  