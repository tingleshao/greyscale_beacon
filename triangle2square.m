function [ final_pic ] = triangle2square( tri1, list_of_pts, list_of_intensity )
    % list of intensity: n x 3 with every row a color rgb pixel value
    % tri1: 3 by 2 matrix
    % tri2: 3 by 2 matrix '
    tri2 = [1,1; 8,1; 1,8];
    T = maketform('affine',tri1,tri2); % TODO: may change to the recommended function later 
    transformed_pts = zeros(size(list_of_intensity,1), 2);
    
    % get transformed pts
    imageTotransform = zeros(64,64,3);
    for i = 1:size(list_of_pts,1)
        pt = list_of_pts(i,:);
        imageTotransform(pt(2),pt(1),:) = list_of_intensity(i,1,:);
    end
  %  figure;
  %  subplot(1,2,1);
   % imshow(imageTotransform/255);
    final_pic = zeros(8,8,3);
    fy = 1;
    fx = 1;
    timtransform = imtransform(imageTotransform,T);
    
    for x = 1:size(timtransform,2)
        for y =  1:size(timtransform,1)
            if timtransform(y,x,1) > 0
                if fx == 9
                    break
                end
                final_pic(fy,fx,:) = timtransform(y,x,:);
                fy = fy+1;
                if fy > 8-fx+1
                    fx = fx+1;
                    fy = 1;
                end
            end
        end
    end
    
 %   subplot(1,2,2);
 %   imshow(final_pic/255);
    
  %  for i = 1:size(list_of_pts,1)
  %      pt = double(list_of_pts(i,:));
  %      transformed_pts(i,:) = uint8(tformfwd(pt,T));
  %  end
  %  size(list_of_pts)
  %  size(list_of_intensity)
  %  list_of_intensity
  %  size(transformed_pts)
  %  transformed_pts
    
    % make a picture
  %  pic = zeros(8,8,3);
  %  for i = 1:size(transformed_pts,1)
  %      pt = transformed_pts(i,:);
  %      pic(pt(2), pt(1),:) = list_of_intensity(i,1,:);
  %  end
  %  pict(:,:,1) = pic(:,:,1)';
  %  pict(:,:,2) = pic(:,:,2)'; 
  %  pict(:,:,3) = pic(:,:,3)';
  %  final_pic(:,:,1) = pict(:,:,1) + pic(:,:,1);
  %  final_pic(:,:,2) = pict(:,:,2) + pic(:,:,2);
  %  final_pic(:,:,3) = pict(:,:,3) + pic(:,:,3);

    %  = imresize(final_pic, [8, 8]);
  %  figure;
  %  pic
  %  imshow(pic/255)
    %figure
end

