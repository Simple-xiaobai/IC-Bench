function [distort_I] = imdist_generator(im, dist_type, dist_level)

if ~isnumeric(dist_type) || ~isscalar(dist_type) || ...
       ~isnumeric(dist_level) || ~isscalar(dist_level)
        error('');
end

im = mapmm(im);     
switch dist_type
    case 1
        levels=[0, 0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2, 2.25, 2.5, 2.75, 3, 3.25, 3.5, 3.75, 4, 4.25, 4.5, 4.75, 5, 5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12, 12.5, 13, 13.5, 14, 14.5];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imblurgauss(im, level);
    case 2
        levels = [0.1, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 9.5, 10.0, 10.5, 11.0, 11.5, 12.0, 12.5, 13.0, 13.5, 14.0, 14.5, 15.0, 15.5, 16.0, 16.5, 17.0, 17.5, 18.0, 18.5, 19.0, 19.5];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imsaturate(im, levels(dist_level));
    case 3
        levels=[1, 20, 40, 60, 80, 100, 120, 140, 160, 180, 200, 220, 240, 260, 280, 300, 320, 340, 360, 380, 400, 440, 480, 520, 560, 600, 640, 680, 720, 760, 800, 840, 880, 920, 960, 1000, 1040, 1080, 1120, 1160];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imcompressjp2k(im, levels(dist_level));
    case 4
        levels=[29, 28.5, 28, 27.5, 27, 26.5, 26, 25.5, 25, 24.5, 24, 23.5, 23, 22.5, 22, 21.5, 21, 20.5, 20, 19.5, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0.001];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imcompressjpeg(im, levels(dist_level));
    case 5
        levels=[0, 0.025, 0.05, 0.075, 0.1, 0.125, 0.15, 0.175, 0.2, 0.225, 0.25, 0.275, 0.3, 0.325, 0.35, 0.375, 0.4, 0.425, 0.45, 0.475, 0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95, 1, 1.05, 1.1, 1.15, 1.2, 1.25, 1.3, 1.35, 1.4, 1.45];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imnoisegauss(im, levels(dist_level));
    case 6
        levels = [0,0.3,0.6,0.9,1.2,1.5,1.8,2.1,2.4,2.7,3.0,3.3,3.6,3.9,4.2,4.5,4.8,5.1,5.4,5.7,6.0,6.3,6.6,6.9,7.2,7.5,7.8,8.1,8.4,8.7,9.0,9.3,9.6,9.9,10.2,10.5,10.8,11.1,11.4,11.7];
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imcontrastc(im, levels(dist_level));
    case 7
        levels = linspace(0, 1, 40);
        level = interp1(1:length(levels), levels, dist_level, 'linear', 'extrap');
        distort_I = imghost(im, level);
    otherwise
        error('Unknown distortion type!')
end
distort_I = mapmm(distort_I);

end


