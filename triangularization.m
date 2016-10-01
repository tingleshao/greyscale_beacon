% triangularize the input shape
% input shape: binary image: input_shape,
% number of triangles: n
function [DT] = triangularization(input_shape, n)
% step1: shape is in bianry image format, convert it into list of boundary
% points
%  TODO: any optimizaed way to do this?
boundary = find_boundary(input_shape);
x = [];
y = [];
size_shape = size(boundary);
w = size_shape(2);
h = size_shape(1);
a = 1;
for xx = 1:w
    for yy = 1:h
        if a == 6
            if boundary(yy,xx) > 0
                x = [x; xx];
                y = [y; yy];
            end
            a = 0;
        end
        a = a+1;
    end
end

% step2: connect boundary points to form
P = [x,y];
%triangles = delaunay([x,y]);
DT = delaunayTriangulation(P);

triplot(DT);
