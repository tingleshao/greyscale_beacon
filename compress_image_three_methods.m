% compress the given image using:
% DCT
% Wavelet
% triangularize
function [ dct_res, wavelet_res, triangularize_res ] = compress_image_three_methods( input_image, map )
curr_img = uint8(rgb2gray(input_image)) .* (uint8(map)/uint8(255));
%% DCT
curr_img_small = imresize(curr_img, [64,64]);
dct_curr = dct2(curr_img_small);

compressedDct = zeros(64,64,62);
figure;
subplot(4,5,1)
%imshow(twoImgSmall, [min(min(dct_curr)), max(max(dct_curr))]);
imshow(rgb2gray(input_image));
%title('orig')
xx = 2;
dct_res = [];
for i = 10:3:65
    dctCopy = dct_curr;
    count = 0;
    for x = 1:64
        for y = 1:64
            if (x + y) > i
                dctCopy(x,y) = 0;
                count = count + 1;
            end
        end
    end
    compressedDct(:,:,i-3) = dctCopy;
    subplot(4,5,xx);
    dctTwoImgSmall = idct2(dctCopy);
  %  dct_res = [dct_res, huffman_enc(dctCopy(:))/8];
    fileID = fopen(['data/dct/data',num2str(xx),'.bin'],'w');
    fwrite(fileID,dctCopy);
    fclose(fileID);
        xx = xx + 1;

    %   dctTwoImgSmall(dctTwoImgSmall < 180) = 0;
    %       dctTwoImgSmall(dctTwoImgSmall >= 180) = 255;
    imshow(dctTwoImgSmall, [min(min(dctTwoImgSmall)), max(max(dctTwoImgSmall))]);
    %   title(num2str(ssim(double(dctTwoImgSmall), double(twoImgSmall))));
end

%% Wavelet
n = 5;                   % Decomposition Level
%w = 'sym8';              % Near symmetric wavelet
%w = 'db3';
w = 'sym2';
[c, l] = wavedec2(curr_img_small,n,w); % Multilevel 2-D wavelet decomposition.
figure;
subplot(4,5,1)
imshow(rgb2gray(input_image));
opt = 'gbl'; % Global threshold
xx = 2
wavelet_res = [];
for thr = 10:3:65
    sorh = 'h';  % Hard thresholding
    keepapp = 1; % Approximation coefficients cannot be thresholded
    [xd,cxd,lxd,perf0,perfl2] = wdencmp(opt,c,l,w,n,thr,sorh,keepapp);
    subplot(4,5,22-xx)
    imshow(xd, [min(min(xd)), max(max(xd))])
    fileID = fopen(['data/wavelet/data',num2str(xx),'.bin'],'w');
    fwrite(fileID,[cxd(:); lxd(:)]);
    fclose(fileID);
        xx = xx + 1;

   % wavelet_res = [wavelent_res, huffman_enc([cxd(:); lxd(:)])/8];
end

%% Triangularization 
% may be do some texture k-means later 
figure;
subplot(4,5,1)
imshow(rgb2gray(input_image));

small_map = imresize(map, [64,64]);
small_map(small_map < 10) = 0;
small_map(small_map > 0) = 255;
triangularize_res = triangularization(small_map);
curr_triangularize_res = triangularize_res;
for i = 2:20
    curr_triangularize_res = reduce_triangle(curr_triangularize_res, 1);
    subplot(4,5,20-i+2);
    plot_img_with_tri(input_image) 
    imshow(curr_img_small, curr_triangularize_res);
end

end

