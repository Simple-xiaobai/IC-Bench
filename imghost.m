function generate_imghost_all()
    folderPath = 'D:\generate_distort_images\patchImages';  

    outputFolder = 'D:\generate_distort_images\data_new\imghostImages';  

    if ~exist(outputFolder, 'dir')
        mkdir(outputFolder);
    end

    imageFiles = dir(fullfile(folderPath, '*.jpg'));
    imageFiles = [imageFiles; dir(fullfile(folderPath, '*.png'))];
    imageFiles = [imageFiles; dir(fullfile(folderPath, '*.jpeg'))];
    imageFiles = [imageFiles; dir(fullfile(folderPath, '*.bmp'))];

    if length(imageFiles) < 3
        error('');
    end
    numLevels = 40;
    levels = linspace(0, 1, numLevels); 


    for i = 1:length(imageFiles)
    
        availableIdx = setdiff(1:length(imageFiles), i);
        randIdx = datasample(availableIdx, 2, 'Replace', false);

        
        img = imread(fullfile(folderPath, imageFiles(i).name));

      
        [~, name1, ext1] = fileparts(imageFiles(i).name);

        
        imgFolder = fullfile(outputFolder, name1);
        if ~exist(imgFolder, 'dir')
            mkdir(imgFolder);
        end


        for m = 1:2
            j = randIdx(m);
            img_rand = imread(fullfile(folderPath, imageFiles(j).name));
            [~, name_rand, ~] = fileparts(imageFiles(j).name);

     
            for k = 1:numLevels
                distorted_img = imghost(img, img_rand, levels(k)); 


                outputFileName = sprintf('%s_%s_ghost_%d%s', ...
                                         name1, name_rand, k, ext1);
                outputFilePath = fullfile(imgFolder, outputFileName);

                imwrite(distorted_img, outputFilePath);
            end
        end
    end

    disp(['Ghost ', outputFolder, ' 文件夹中。']);
end

function distorted_img = imghost(img, img1, level)
    img = double(img);
    img1 = double(img1);
    h = size(img,1);
    w = size(img,2);

    new_img1 = imresize(img1, [h w]);

    distorted_img(:,:,1) = round(level*img(:,:,1) + (1-level)*new_img1(:,:,1));
    distorted_img(:,:,2) = round(level*img(:,:,2) + (1-level)*new_img1(:,:,2));
    distorted_img(:,:,3) = round(level*img(:,:,3) + (1-level)*new_img1(:,:,3));
    distorted_img = uint8(distorted_img);
end
