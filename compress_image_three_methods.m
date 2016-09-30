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
subplot(3,21,1)
%imshow(twoImgSmall, [min(min(dct_curr)), max(max(dct_curr))]);
imshow(rgb2gray(input_image));
%title('orig')
for i = 4:65
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
    subplot(3,21,i-2);
    dctTwoImgSmall = idct2(dctCopy);
 %   dctTwoImgSmall(dctTwoImgSmall < 180) = 0;
 %       dctTwoImgSmall(dctTwoImgSmall >= 180) = 255;
    imshow(dctTwoImgSmall, [min(min(dctTwoImgSmall)), max(max(dctTwoImgSmall))]);
 %   title(num2str(ssim(double(dctTwoImgSmall), double(twoImgSmall))));
end

%% Wavelet
n = 10;                   % Decomposition Level
w = 'sym8';              % Near symmetric wavelet
[c l] = wavedec2(curr_img_small,n,w); % Multilevel 2-D wavelet decomposition.
figure;
subplot(4,5,1)
imshow(rgb2gray(input_image));
opt = 'gbl'; % Global threshold
for thr = 1:19
sorh = 'h';  % Hard thresholding
keepapp = 1; % Approximation coefficients cannot be thresholded
[xd,cxd,lxd,perf0,perfl2] = wdencmp(opt,c,l,w,n,thr,sorh,keepapp);
subplot(4,5,thr+1)
imshow(xd)
end
end

