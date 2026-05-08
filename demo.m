% setup
clear; clc;

addpath(genpath('patchImages'));
addpath(genpath(pwd));


imageFolderPath = 'D:\generate_distort_images\patchImages';


imageFiles = dir(fullfile(imageFolderPath, '*.jpg'));
imageFiles = [imageFiles; dir(fullfile(imageFolderPath, '*.png'))];


outerSavePath = fullfile('.', 'data_new/imcompressjpegImages'); 


if ~isfolder(outerSavePath)
    mkdir(outerSavePath);
end
type =10;
dist_type = ["blurgauss", "blurlens", "blurmotion", "colordiffuse", "colorshift", "colorquantize", "colorsaturate", "saturate", "compressjptk", "compressjpeg", "noisegauss", "contrastc"];
totallevel=40;

for k = 1:length(imageFiles)
    original_img_name = imageFiles(k).name;
    [~, name, ext] = fileparts(original_img_name);
    

    ref_im_path = fullfile(imageFolderPath, original_img_name);
    ref_im = imread(ref_im_path);
    

    innerSavePath = fullfile(outerSavePath, name); 
    if ~isfolder(innerSavePath)
        mkdir(innerSavePath);
    end

    img = cell(1, totallevel);
    for index = 1:totallevel
        [dist_im] = imdist_generator(ref_im, type, index);
        img{index} = dist_im;

        %filename = fullfile(innerSavePath, sprintf('%s_%s_%.f%s', name, dist_type(type), index, ext)); 
        filename = fullfile(innerSavePath, sprintf('%s_%s_%d%s', name, dist_type(type), index, ext)); 
        imwrite(dist_im, filename); 
    end
  
end
