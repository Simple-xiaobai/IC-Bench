function generate_imghost_all()
    % 设置源图像文件夹路径（可以改成你自己的路径）
    folderPath = 'D:\generate_distort_images\patchImages_10';  % <-- 修改为你自己的图像文件夹路径

    % 指定输出文件夹的绝对路径或相对路径
    outputFolder = 'D:\generate_distort_images\data_new_10\imghostImages';  % <-- 修改为你希望的输出路径

    if ~exist(outputFolder, 'dir')
        mkdir(outputFolder);
    end

    % 获取所有支持格式的图像文件
    imageFiles = dir(fullfile(folderPath, '*.jpg'));
    imageFiles = [imageFiles; dir(fullfile(folderPath, '*.png'))];
    imageFiles = [imageFiles; dir(fullfile(folderPath, '*.jpeg'))];
    imageFiles = [imageFiles; dir(fullfile(folderPath, '*.bmp'))];

    if length(imageFiles) < 3
        error('至少需要三张图像来执行此操作');
    end
    numLevels = 40;
    levels = linspace(0, 1, numLevels);  % 用于计算 ghost 效果

    % 遍历所有图像
    for i = 1:length(imageFiles)
        
        % 随机选择两个不同的索引，不包括当前图像
        availableIdx = setdiff(1:length(imageFiles), i);
        randIdx = datasample(availableIdx, 2, 'Replace', false);

        % 读取图像
        img = imread(fullfile(folderPath, imageFiles(i).name));

        % 获取原始图像名称（不带扩展名）
        [~, name1, ext1] = fileparts(imageFiles(i).name);

        % 创建子文件夹
        imgFolder = fullfile(outputFolder, name1);
        if ~exist(imgFolder, 'dir')
            mkdir(imgFolder);
        end

        % 分别对每个随机图像做 ghost 处理
        for m = 1:2
            j = randIdx(m);  % 当前使用的随机图像索引
            img_rand = imread(fullfile(folderPath, imageFiles(j).name));
            [~, name_rand, ~] = fileparts(imageFiles(j).name);

            % 生成每个 level 的 ghost 图像
            for k = 1:numLevels
                distorted_img = imghost(img, img_rand, levels(k)); % 注意这里只传两个图像

                % 构造输出文件名：源图名_随机图名_ghost_levelX
                outputFileName = sprintf('%s_%s_ghost_%d%s', ...
                                         name1, name_rand, k, ext1);
                outputFilePath = fullfile(imgFolder, outputFileName);

                % 保存图像
                imwrite(distorted_img, outputFilePath);
            end
        end
    end

    disp(['Ghost 效果处理完成，结果已保存到 ', outputFolder, ' 文件夹中。']);
end
%% ========== 更新后的 imghost 函数 ==========
function distorted_img = imghost(img1, img, level)
    % 只融合两张图像
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