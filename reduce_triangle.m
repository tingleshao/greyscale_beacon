% reduce the triangle by removing n points with shortest sum of distance
% between its 3 neighbors
function [ new_tri ] = reduce_triangle( tri, n )

pts = tri.Points;
pts_distance = []; % three-neightbor distance for all pts
% todo: if less than 4 pts, do nothing
for i = 1:length(pts)
    pt = pts(i);
    dists = []; % distances between current pt and all other pts
    x = pt(1);
    y = pt(2);
    for j = 1:length(pts)
        if j ~= i
            other_pt = pts(j);
            other_x = other_pt(1);
            other_y = other_pt(2);
            dists = [dists, (other_x - x)^2 + (other_y - y)^2];
        end
    end
    sorted_dists = sort(dists);
    pts_distance = [pts_distance (sorted_dists(1) + sorted_dists(2) + sorted_dists(3))];
end
remove_index = [];
for i = 1:n
    curr_remove_index =  find(pts_distance == min(pts_distance));
    pts_distance(remove_index) = [];
    remove_index = [remove_index curr_remove_index];
end
% remove the points in the tri
new_tri = tri;
new_tri.Points(remove_index) = [];
end

