function [  ] = generate_jpeg_compressed_list( jpeg_dir, orig_img )

for quality = 1:100
    imwrite(orig_img, [jpeg_dir, 'quality_', num2str(quality), '.jpg'],'Quality', quality);
end

end

