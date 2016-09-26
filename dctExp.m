twoImg = imread('imgs/lenna/lenna.jpg'); 
%twoImgSmall = rgb2gray(imresize(twoImg, [64,64]));
twoImgSmall = imresize(twoImg, [64,64]);
dctTwo = dct2(twoImgSmall);

compressedDct = zeros(64,64,62);
subplot(3,21,1)
imshow(twoImgSmall, [min(min(twoImgSmall)), max(max(twoImgSmall))]);
title('orig')
for i = 4:65
    dctCopy = dctTwo;
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

    title(num2str(ssim(double(dctTwoImgSmall), double(twoImgSmall))));
end


