function [ dct_res, wavelet_res, curr_triangularize_res, dct_size, wavelet_size, tri_size, param_list ] = compress_image_three_methods( input_image, map, work_dir )
% compress the given image using:
% DCT
% Wavelet
% triangularize
dct_res = 0;
wavelet_res = 0;
dct_size= 0;
wavelet_size=0;
tri_size=0;
param_list  = 0;
curr_triangularize_res = 0;

do_dct = 1;
do_wavelet = 1;
do_tri1 = 1;
do_tri2 = 1;

addpath(genpath('encoder/'));
curr_img(:,:,1) = uint8(input_image(:,:,1)) .* (uint8(map)/uint8(255));
curr_img(:,:,2) = uint8(input_image(:,:,2)) .* (uint8(map)/uint8(255));
curr_img(:,:,3) = uint8(input_image(:,:,3)) .* (uint8(map)/uint8(255));
%curr_img = uint8(input_image) .* (uint8(map)/uint8(255));

background_size = length(imencode(imresize(input_image, [3,3])));
background = imresize(imresize(input_image,[3,3]),[64,64]);

input_imager = uint8(input_image(:,:,1)) .* (uint8(255-map)/uint8(255));
input_imageg = uint8(input_image(:,:,2)) .* (uint8(255-map)/uint8(255));
input_imageb = uint8(input_image(:,:,3)) .* (uint8(255-map)/uint8(255));

input_image_background_only(:,:,1) = input_imager;
input_image_background_only(:,:,2) = input_imageg;
input_image_background_only(:,:,3) = input_imageb;

dct_wavelet_background = imresize(imresize(input_image_background_only,[3,3]),[64,64]);
dct_wavelet_background_size = length(imencode(imresize(input_image, [3,3])));

curr_img_small = imresize(curr_img, [64,64]);
curr_img_yuv = rgb2ycbcr(curr_img_small);
do_prev3 = 1;
if do_prev3
    if do_dct
        %% DCT
        dct_curr_y = dct2(curr_img_yuv(:,:,1));
        dct_curr_u = dct2(imresize(curr_img_yuv(:,:,2),[32,32]));
        dct_curr_v = dct2(imresize(curr_img_yuv(:,:,3),[32,32]));

    %    dct_curr_y = dct2(curr_img_small(:,:,1));
    %    dct_curr_u = dct2(curr_img_small(:,:,2));
     %   dct_curr_v = dct2(curr_img_small(:,:,3));

        %compressedDct = zeros(64,64,62);
        figure;
        subplot(4,5,1)
        %imshow(twoImgSmall, [min(min(dct_curr)), max(max(dct_curr))]);
        imshow(imresize(input_image, [64,64]));
        %title('orig')
        xx = 2;
        dct_res = [];
        for i = 10:6:123
            dct_copy_y = dct_curr_y;
            dct_copy_u = dct_curr_u;
            dct_copy_v = dct_curr_v;
            count = 0;
            for x = 1:64
                for y = 1:64
                    if (x + y) > i
                        dct_copy_y(x,y) = 0;
                        count = count + 1;
                    end
                end
            end
            for x = 1:32
                for y = 1:32
                    if (x+y) > i/2
                        dct_copy_u(x,y) = 0;
                        dct_copy_v(x,y) = 0;
                        count = count + 1;
                    end
                end
            end
            % compressedDct(:,:,i-3) = dctCopy;
            subplot(4,5,xx);
            idct_curr_y = idct2(dct_copy_y);
        %    idct_curr_u = imresize(idct2(double(int8(dct_copy_u))), [64,64]);
        %    idct_curr_v = imresize(idct2(double(int8(dct_copy_v))), [64,64]);

            idct_curr_u = imresize(idct2(dct_copy_u),[64,64]);
            idct_curr_v = imresize(idct2(dct_copy_v),[64,64]);
            %  dct_res = [dct_res, huffman_enc(dctCopy(:))/8];
            % fileID = fopen(['data/dct/data',num2str(xx),'.bin'],'w');
            %  fwrite(fileID,dctCopy);
            %  fclose(fileID);
            idct_curr(:,:,1) = idct_curr_y;
            idct_curr(:,:,2) = idct_curr_u;
            idct_curr(:,:,3) = idct_curr_v;
            xx = xx + 1;
            % dctTwoImgSmall(dctTwoImgSmall < 180) = 0;
            % dctTwoImgSmall(dctTwoImgSmall >= 180) = 255;
            %  imshow(idct_curr, [min(min(idct_curr)), max(max(idct_curr))]);
        %    imshow(ycbcr2rgb(idct_curr));
            final_img = dct_wavelet_background + ycbcr2rgb(uint8(idct_curr));
         %   final_img = ycbcr2rgb(uint8(idct_curr));

            imshow(final_img);
           bits = length(gzipencode([int8(dct_copy_y(:)); int8(dct_copy_y(:)); int8(dct_copy_y(:))]))+ dct_wavelet_background_size;
 imwrite(final_img, [work_dir, 'jpeg_res/thr_', num2str(i), '_size_', num2str(bits), '.png']);
     %       bits = length(gzipencode([int8(dct_copy_y(:)); int8(dct_copy_y(:)); int8(dct_copy_y(:))]));
            raw_bits = length([int8(dct_copy_y(:)); int8(dct_copy_y(:)); int8(dct_copy_y(:))]);
            
            title(num2str(bits));
        end
    end
    
    %% Wavelet
    if do_wavelet
        n = 5;                   % Decomposition Level
        %w = 'sym8';              % Near symmetric wavelet
        %w = 'db3';
        w = 'sym2';
        [c_y, l_y] = wavedec2(curr_img_small(:,:,1), n, w);
        [c_u, l_u] = wavedec2(curr_img_small(:,:,2), n, w);
        [c_v, l_v] = wavedec2(curr_img_small(:,:,3), n, w);
        %[c, l] = wavedec2(curr_img_small,n,w); % Multilevel 2-D wavelet decomposition.
        figure;
        subplot(4,5,1)
        imshow(input_image);
        opt = 'gbl'; % Global threshold
        xx = 2;
        wavelet_res = [];
        for thr = 1:1:19
            %
            % sorh = 'h';  % Hard thresholding
            % keepapp = 1; % Approximation coefficients cannot be thresholded
            % [xd_y, cxd_y, lxd_y, perf0, perfl2] = wdencmp(opt,c_y,l_y,w,n,thr,sorh,keepapp);
            % [xd_u, cxd_u, lxd_u, perf0, perfl2] = wdencmp(opt,c_u,l_u,w,n,thr,sorh,keepapp);
            %  [xd_v, cxd_v, lxd_v, perf0, perfl2] = wdencmp(opt,c_v,l_v,w,n,thr,sorh,keepapp);
            %  xd(:,:,1) = xd_y;
            %  xd(:,:,2) = xd_u;
            %  xd(:,:,3) = xd_v;
            % % xd(:,:,2) = imresize(xd_u,[64,64]);
            % xd(:,:,3) = imresize(xd_v,[64,64]);
            
            wcompress('c',curr_img_small,'foo.wtc','gbl_mmc_h', 'comprat', thr);
            xd = wcompress('u','foo.wtc');
            xd = xd+dct_wavelet_background;
            subplot(4,5,xx)
            imshow(xd)
            % imshow(ycbcr2rgb(xd));
            %    [min(min(xd_y)), max(max(xd_y))]
            
            %  [min(min(xd_u)), max(max(xd_u))]
            %  [min(min(xd_v)), max(max(xd_v))]
            %  imshow(xd_v, [min(min(xd_v)), max(max(xd_v))]);
            %  fileID = fopen(['data/wavelet/data',num2str(xx),'.bin'],'w');
            %  fwrite(fileID,[cxd(:); lxd(:)]);
            %  fclose(fileID);
            
            xx = xx + 1;
            % wavelet_res = [wavelent_res, huffman_enc([cxd(:); lxd(:)])/8];
            %   bits = length(gzipencode(uint8([cxd_y(:); lxd_y(:); cxd_u(:); lxd_u(:); cxd_v(:); lxd_v(:)])));
            bits = 64 * 64 * 24 * thr/800+dct_wavelet_background_size;
            title(num2str(bits));
            imwrite(xd, [work_dir, 'wavelet_res/thr_', num2str(thr), '_size_', num2str(bits), '.png']);
        end
    end
    %% Triangularization
    % may be do some texture k-means later
    if do_tri1
        figure;
        subplot(4,5,1)
        imshow(rgb2gray(input_image));
        
        small_map = imresize(map, [64,64]);
        small_map(small_map < 10) = 0;
        small_map(small_map > 0) = 255;
        triangularize_res = triangularization(small_map);
        curr_triangularize_res = triangularize_res;
        for i = 2:20
            if (size(curr_triangularize_res.Points,1) <= 3)
                break
            end
            curr_triangularize_res = reduce_triangle(curr_triangularize_res, 1);
            subplot(4,5,20-i+2);
            %   plot_img_with_tri(input_image, curr_triangularize_res)
            %   imshow(curr_img_small, curr_triangularize_res);
            [canvas, foo] = reduce_img_from_tri(imresize(input_image, [64,64]), curr_triangularize_res, background);
            [bits , raw_bits]= compute_tri_size(curr_triangularize_res);
            title([num2str(bits+background_size),',', num2str(raw_bits)]);
            numtri = size(curr_triangularize_res.ConnectivityList,1);
            imwrite(canvas, [work_dir, 'tri1_res/numtri_', num2str(numtri), '_size_', num2str(bits+background_size), '.png']);
        end
    end
end

%% Tri - texture
if do_tri2
    figure;
    subplot(4,5,1)
    imshow(rgb2gray(input_image));
    
    small_map = imresize(map, [64,64]);
    small_map(small_map < 10) = 0;
    small_map(small_map > 0) = 255;
    triangularize_res = triangularization(small_map);
    
    curr_triangularize_res = triangularize_res;
    for i = 2:20
        if (size(curr_triangularize_res.Points,1) <= 3)
            break
        end
        curr_triangularize_res = reduce_triangle(curr_triangularize_res, 1);
        subplot(4,5,20-i+2);
        %   plot_img_with_tri(input_image, curr_triangularize_res)
        %   imshow(curr_img_small, curr_triangularize_res);
        [canvas, blen] =  reduce_img_from_tri_texture(imresize(input_image, [64,64]), curr_triangularize_res,1, work_dir);
        %   [bits , raw_bits]= compute_tri_size(curr_triangularize_res);
        %   title([num2str(bits),',', num2str(raw_bits)]);
    end
    %dct_res = canvas
end
end

