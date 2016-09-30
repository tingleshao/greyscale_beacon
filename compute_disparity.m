% compute the disparity with some pre-coded params 
function [disparityMap2, disparityMap] = compute_disparity(left, right)
  disparityRange = [-6 10];
  disparityMap = disparity(rgb2gray(left), rgb2gray(right), 'BlockSize', 15, 'DisparityRange', disparityRange);
  figure;
  imshow(disparityMap,disparityRange);
  title('Disparity Map');
  colormap jet
  colorbar
  disparityMap2 = uint8(((disparityMap + 6.0) / 16.0)*255.0);