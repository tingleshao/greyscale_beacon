% TODO: make a plot of img size and img

for threshold = 1:9
    [b, outimg]= fractal('lenna64map.png', threshold/30, 0);
    subplot(2,9,threshold);
    imshow(outimg)
    title(sprintf('%d',b));
 %   [c, outimg2] = fractal('lenna64mapshift.png', threshold/10, 0);
 %   subplot(2,9,threshold+9);
 %   imshow(outimg2)
 %   title(sprintf('%d',c));
end