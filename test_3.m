% test the different segmentations 

signs_id = 0:19;
signs_dir = 'imgs/disparity/test_image/signs/set';
signs_hits = [];
signs_miss = [];
dsigns_hits = [];
dsigns_miss = [];

for i = signs_id
    curr_sign_dir = [signs_dir, num2str(i), '/']
    curr_seg = imread([curr_sign_dir, 'segs/final_map.png']);
    curr_gc = rgb2gray(imread([curr_sign_dir, 'gc.png']));
    curr_gc(curr_gc<100) = 0;
    curr_gc(curr_gc>0) = 255;
  %  total_pixels = sum(sum(curr_gc==255));
    intersection = sum(sum((curr_seg==curr_gc) .* (curr_gc==255)));
    unionx = (curr_seg==255) + (curr_gc==255);
    for x = 1:288
        for y = 1:288
            if unionx(y,x) == 2
                unionx(y,x) = 1;
            end
        end
    end
    union = sum(sum(unionx));
  %  miss_vs_total = sum(sum(curr_seg~=curr_gc)) / total_pixels;
    signs_hits = [signs_hits; intersection/union];
 %   signs_miss = [signs_miss; miss_vs_total];
    
    depths_seg = imread([curr_sign_dir, 'segs/disparity_map1.png']);
    depths_seg(depths_seg<4) = 0;
    depths_seg(depths_seg>0) = 255;
    dintersection = sum(sum((curr_seg==depths_seg) .* (curr_gc==255)));
    dunionx = (depths_seg==255) + (curr_gc==255);
    for x = 1:288
        for y = 1:288
            if dunionx(y,x) == 2
                dunionx(y,x) = 1;
            end
        end
    end
    dunion = sum(sum(dunionx));
 %   dmiss_vs_total = sum(sum(depths_seg~=curr_gc)) / total_pixels;
    dsigns_hits = [dsigns_hits; dintersection/dunion];
 %   dsigns_miss = [dsigns_miss; dmiss_vs_total];
end
hFig = figure(1);

set(hFig, 'Position', [100 100 250 250])
bar([mean(signs_hits) 0; 0, mean(dsigns_hits)]);
%figure;
%plot(signs_id, signs_hits, '-*', signs_id, dsigns_hits, '-s', 'MarkerSize',6)
h_legend=legend('Combined segmentation', 'Depth-based segmentation');
set(h_legend,'FontSize',10);
set(gca,'fontsize',11)