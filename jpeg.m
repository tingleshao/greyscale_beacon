function [ ] = jpeg( img_name )
%JPEG Summary of this function goes here
%   Detailed explanation goes here
input_image =im2double(imread(img_name));
input_image_64x64 = imresize(input_image, [64,64]);

dct_8x8_image_of_64x64 = image_8x8_block_dct(input_image_64x64);
imshow(input_image_64x64);
title('image');
imshow(dct_8x8_image_of_64x64);
title('dct of image');

mean_matrix_8x8 = zeros(8,8);

for m = 0:7
    for n = 0:7
        mean_matrix_8x8 = mean_matrix_8x8x + ...
            abs(dct_8x8_image_of_64x64(m*8+[1:8], n*8+[1:8])).^2;
    end
end

mean_matrix_8x8_transposed = mean_matrix_8x8';
mean_vector = mean_matrix_8x8_transposed(:);

[sorted_mean_vector, original_indices] = sort(mean_vector);

sorted_mean_vector = sorted_mean_vector(end:-1:1);
original_indices = original_indices(end:-1:-1);

original_image = im2double(imresize(imread(img_name), [64,64]));

coef_selection_matrix = zeros(8,8);
compressed_set = [1 3 5 10 15 20 30 40];

for number_of_coefficient = 1:64
    [y,x] = find(mean_matrix_8x8==max(max(mean_matrix_8x8)));
    coef_selection_matrix(y,x) = 1;
    
    selection_matrix = repmat(coef_selection_matrix, 16, 16);
    mean_matrix_8x8(y,x) = 0;
    
    compressed_image = image_8x8_block_dct(original_iamge) .* selection_matrix;
    
    restored_image = image_8x8x_block_inf_dct(compressed_image);
    
    SNR(number_of_coefficient) = calc_snr(original_iamge, restored_image); 
     
    if ~isempty(find(number_of_coefficient==compressed_set)) 
        if (number_of_coefficient==1)
            figure;
            subplot(3,3,1);
            imshow(original_image);
            title('original image');
        end
        subplot(3, 3, find(number_of_coefficient==compressed_set)+1);
        imshow(restored_image);
        title(sprintf('restored image with %d coeffs', number_of_coefficient));
    end
end

% plot the SNR graph
figure;
plot( [1:64],20*log10(SNR) );
xlabel( 'numer of coefficients taken for compression' );
ylabel( 'SNR [db] ( 20*log10(.) )' );
title( 'SNR graph for picture number 8, section 1.8' );
grid on;

function out = pdip_dct2( in )

% get input matrix size
N = size(in,1);

% build the matrix
n = 0:N-1;
for k = 0:N-1
   if (k>0)
      C(k+1,n+1) = cos(pi*(2*n+1)*k/2/N)/sqrt(N)*sqrt(2);
   else
      C(k+1,n+1) = cos(pi*(2*n+1)*k/2/N)/sqrt(N);
   end   
end

out = C*in*(C');

% ---------------------------------------------------------------------------------
% pdip_inv_dct2 - implementation of an inverse 2 Dimensional DCT
%
% assumption: input matrix is a square matrix !
% ---------------------------------------------------------------------------------
function out = pdip_inv_dct2( in )

% get input matrix size
N = size(in,1);

% build the matrix
n = 0:N-1;
for k = 0:N-1
   if (k>0)
      C(k+1,n+1) = cos(pi*(2*n+1)*k/2/N)/sqrt(N)*sqrt(2);
   else
      C(k+1,n+1) = cos(pi*(2*n+1)*k/2/N)/sqrt(N);
   end   
end

out = (C')*in*C;

% ---------------------------------------------------------------------------------
% plot_bases - use the inverse DCT in 2 dimensions to plot the base pictures
%
% Note: we can get resolution be zero pading of the input matrix !!!
%       that is by calling: in = zeros(base_size*resolution)
%       where:  resolution is an integer > 1
%       So I will use zero pading for resolution (same as in the fourier theory)
%       instead of linear interpolation.
% ---------------------------------------------------------------------------------
function plot_bases( base_size,resolution,plot_type )

figure;
for k = 1:base_size
   for l = 1:base_size
      in = zeros(base_size*resolution);
      in(k,l) = 1;							% "ask" for the "base-harmonic (k,l)"
      subplot( base_size,base_size,(k-1)*base_size+l );
      switch lower(plot_type)
      case 'surf3d', surf( pdip_inv_dct2( in ) );
      case 'mesh3d', mesh( pdip_inv_dct2( in ) );
      case 'mesh2d', mesh( pdip_inv_dct2( in ) ); view(0,90);
      case 'gray2d', imshow( 256*pdip_inv_dct2( in ) );         
      end     
      axis off;
   end
end

% add a title to the figure
subplot(base_size,base_size,round(base_size/2));
h = title( 'Bases of the DCT transform (section 1.3)' );
set( h,'FontWeight','bold' );

% ---------------------------------------------------------------------------------
% image_8x8_block_dct - perform a block DCT for an image
% ---------------------------------------------------------------------------------
function transform_image = image_8x8_block_dct( input_image )

transform_image = zeros( size( input_image,1 ),size( input_image,2 ) );
for m = 0:15
    for n = 0:15
        transform_image( m*8+[1:8],n*8+[1:8] ) = ...
            pdip_dct2( input_image( m*8+[1:8],n*8+[1:8] ) );
    end
end


% ---------------------------------------------------------------------------------
% image_8x8_block_inv_dct - perform a block inverse DCT for an image
% ---------------------------------------------------------------------------------
function restored_image = image_8x8_block_inv_dct( transform_image )

restored_image = zeros( size( transform_image,1 ),size( transform_image,2 ) );
for m = 0:15
    for n = 0:15
        restored_image( m*8+[1:8],n*8+[1:8] ) = ...
            pdip_inv_dct2( transform_image( m*8+[1:8],n*8+[1:8] ) );
    end
end


% ---------------------------------------------------------------------------------
% calc_snr - calculates the snr of a figure being compressed
%
% assumption: SNR calculation is done in the following manner:
%             the deviation from the original image is considered 
%             to be the noise therefore:
%
%                   noise = original_image - compressed_image
%
%             the SNR is defined as:  
%
%                   SNR = energy_of_image/energy_of_noise
%
%             which yields: 
%
%                   SNR = energy_of_image/((original_image-compressed_image)^2)
% ---------------------------------------------------------------------------------
function SNR = calc_snr( original_image,noisy_image )

original_image_energy = sum( original_image(:).^2 );
noise_energy = sum( (original_image(:)-noisy_image(:)).^2 );
SNR = original_image_energy/noise_energy;




end

