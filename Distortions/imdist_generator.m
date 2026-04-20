function [distort_I] = imdist_generator(im, dist_type, dist_level)
% given the image, distortion type id and distortion level, generate
% distorted image

if ~isnumeric(dist_type) || ~isscalar(dist_type) || ...
       ~isnumeric(dist_level) || ~isscalar(dist_level)
        error('dist_type 和 dist_level 必须是标量数值');
end

im = mapmm(im);     
switch dist_type
    case 1
        %levels = [0.00001,0.5,1,1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5,8,8.5,9,9.5,10,10.5,11,11.5,12,12.5,13,13.5,14,14.5];
        levels = [0.25,0.75,1.25,1.75,2.25,2.75,3.25,3.75,4.25,4.75];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imblurgauss(im, level);
    case 2
        levels = [0.1, 1, 2,4,8,10, 13,15,17,20,22,23,26,27,35];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imblurlens(im, levels(dist_level));
    case 3
        levels = [0.000000001, 2.5, 5.0, 7.5, 10.0, 12.5, 15.0, 17.5, 20.0, 22.5,25.0, 27.5, 30.0, 32.5, 35.0, 37.5, 40.0, 42.5, 45.0, 47.5,50.0, 52.5, 55.0, 57.5, 60.0, 62.5, 65.0, 67.5, 70.0, 72.5];
        %levels = [0.1, 1, 2,4,8,10, 13,15,17,20,22,23,26,27,35];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imblurmotion(im, levels(dist_level));
    case 4
        levels = [0.1, 1, 2,4,8,10, 13,15,17,20,22,23,26,27,35];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imcolordiffuse(im, levels(dist_level));
    case 5
        levels = [0.1, 1, 2,4,8,10, 13,15,17,20,22,23,26,27,35];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imcolorshift(im, levels(dist_level));
    case 6
        levels = [0.1, 1, 2,4,8,10, 13,15,17,20,22,23,26,27,35];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imcolorquantize(im, levels(dist_level));
    case 7
        levels = [0.1, 1, 2,4,8,10, 13,15,17,20,22,23,26,27,35];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imcolorsaturate(im, levels(dist_level));
    case 8
        levels = [0.1, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 9.5, 10.0, 10.5, 11.0, 11.5, 12.0, 12.5, 13.0, 13.5, 14.0, 14.5, 15.0, 15.5, 16.0, 16.5, 17.0, 17.5, 18.0, 18.5, 19.0, 19.5];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imsaturate(im, levels(dist_level));
    case 9
        %levels = [1,40,80,120,160,200,240,280,320,360,400,440,480,520,560,600,640,680,720,760,800,840,880,920,960,1000,1040,1080,1120,1160];
        levels = [20,60,100,140,180,220,260,300,340,380]
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imcompressjp2k(im, levels(dist_level));
    case 10
        %levels=[29, 28, 27, 26, 25, 24,23, 22, 21, 20, 19, 18,17, 16, 15, 14, 13, 12,11, 10,  9,  8,  7,  6,5,  4,  3,  2,  1,  0.001]
        levels = [28.5,27.5,26.5,25.5,24.5,23.5,22.5,21.5,20.5,19.5];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imcompressjpeg(im, levels(dist_level));
    case 11
        levels = [0.025,0.075,0.125,0.175,0.225,0.275,0.325,0.375,0.425,0.475];
        %levels = [0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,0.9,0.95,1,1.05,1.1,1.15,1.2,1.25,1.3,1.35,1.4,1.45];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imnoisegauss(im, levels(dist_level));
    case 12
        levels = [0,0.3,0.6,0.9,1.2,1.5,1.8,2.1,2.4,2.7,3.0,3.3,3.6,3.9,4.2,4.5,4.8,5.1,5.4,5.7,6.0,6.3,6.6,6.9,7.2,7.5,7.8,8.1,8.4,8.7,9.0,9.3,9.6,9.9,10.2,10.5,10.8,11.1,11.4,11.7];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imcontrastc(im, levels(dist_level));
    case 13
        levels = [0.01,0.02,0.03,0.04,0.05,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imnoiseimpulse(im, levels(dist_level));
    case 14
        levels = [0.1, 1, 2,4,8,10, 13,15,17,20,22,23,26,27,35];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imnoisemultiplicative(im, levels(dist_level));
    case 15
        levels = [0.1, 1, 2,4,8,10, 13,15,17,20,22,23,26,27,35];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imdenoise(im, levels(dist_level));
    case 16
        levels = [0.1, 1, 2,4,8,10, 13,15,17,20,22,23,26,27,35];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imbrighten(im, levels(dist_level));
    case 17
        levels = [0.1, 1, 2,4,8,10, 13,15,17,20,22,23,26,27,35];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imdarken(im, levels(dist_level));
    case 18
        levels = [0.1, 1, 2,4,8,10, 13,15,17,20,22,23,26,27,35];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = immeanshift(im, levels(dist_level));
    case 19
        levels = [0.1, 1, 2,4,8,10, 13,15,17,20,22,23,26,27,35];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imjitter(im, levels(dist_level));
    case 20
        levels = [0.1, 1, 2,4,8,10, 13,15,17,20,22,23,26,27,35];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imnoneccentricity(im, levels(dist_level));
    case 21
        levels = [1.1, 1.2, 2,4,8,10, 13,15,17,20,22,23,26,27,35];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = impixelate(im, levels(dist_level));
    case 22
        levels = [0.1, 1, 2,4,8,10, 13,15,17,20,22,23,26,27,35];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imnoisequantize(im, levels(dist_level));
    case 23
        levels = [0.1, 1, 2,4,8,10, 13,15,17,20,22,23,26,27,35];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imcolorblock(im, levels(dist_level));
    case 24
        levels = [0.1, 1, 2,4,8,10, 13,15,17,20,22,23,26,27,35];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imsharpenHi(im, levels(dist_level));
    case 25
        
        levels = [0.1, 1, 2,4,8,10, 13,15,17,20,22,23,26,27,35];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imnoisecolorcomp(im, levels(dist_level));
 
    otherwise
        error('Unknown distortion type!')
end
distort_I = mapmm(distort_I);

end