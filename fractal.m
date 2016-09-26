% a function that does the same thing as fractal_compression/lib/main but
% allows you to choose images by giving filename as an argument.

function [bytes_in_fixed, outim] = fractal(img_name, thr, plot) 
%% input image 
I = imread(img_name);
I = imresize(I, [64, 64]);
I(find(I==194))=63;
I(find(I==82))=31;
I(find(I==119))=45;
I(find(I==133))=23;
unique(I)
if plot==1
figure; 
imshow(I); 
title('Original Image'); 
drawnow;
end
tic; 
%% Qualtree Decomposition 
s = qtdecomp(I, thr, [2, 32]);
[i, j, blksz] = find(s); 
blkcount = length(i);
avg = zeros(blkcount, 1);
for k = 1:blkcount
  %  avg(k) = mean2(I(i(k):i(k)+blksz(k)-1, j(k):j(k)+blksz(k)-1));
  submtx = I(i(k):i(k)+blksz(k)-1, j(k):j(k)+blksz(k)-1);
  avg(k) = mode(submtx(:));
end
avg = uint8(avg);
if plot==1
figure;
imshow((full(s))); 
title('Quadtree Decomposition');
drawnow;
end
%% Huffman Encoding
i(end+1) = 0;
j(end+1) = 0;
blksz(end+1) = 0;
data = [i; j; blksz; avg];
data = single(data);
symbols = unique(data)
counts = hist(data(:), symbols);
p = counts ./ sum(counts); 
sp = round(p * 1000);
dict = huffmandict(symbols, p');
comp = huffmanenco(data, dict);
%% Compressed 
t = toc;
fprintf('Time taken for compression = %f seconds \n', t);
bits_in_original = 8 * 64 * 64;
bits_in_final = length(comp) + 8 * length(symbols) + 8 * length(sp);
bits_in_fixed = length(comp);
bytes_in_original = 64 * 64
bytes_in_final = int32(length(comp) / 8 + length(symbols) + length(sp))
bytes_in_fixed = int32(length(comp) / 8)
CR = bits_in_original / bits_in_final;
fprintf('compression ratio= %f\n', CR);
%% Huffman Decoding 
tic;
datanew = huffmandeco(comp, dict);
zeroindx = find(data==0);
inew = datanew(1:zeroindx(1)-1);
jnew = datanew(zeroindx(1)+1 : zeroindx(2)-1);
blksznew = datanew(zeroindx(2)+1 : zeroindx(3)-1);
avgnew = datanew(zeroindx(3)+1 : end);
%% Decompressed image
avgnew = uint8(avgnew);
for k = 1:blkcount
    outim(inew(k):inew(k)+blksznew(k)-1, jnew(k):jnew(k)+blksznew(k)-1) = avgnew(k);
end
if plot == 1
figure;
imshow(outim);
title('Decompressed image');
drawnow;
end
%% PSNR calculation
t = toc;
fprintf('Time taken for Decompression = %f seconds\n', t);
hpsnr = vision.PSNR;
psnr = step(hpsnr, I, outim);
fprintf('PSNR= %f\n', psnr);



