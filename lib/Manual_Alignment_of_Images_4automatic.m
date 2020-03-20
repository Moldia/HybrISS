%% align a floating image on top of a reference image
%  need to give rotation angle and translation matrix
%  last update, 2015-2-18, Xiaoyan


%% input
ref_image = 'O:\dRNA project\20x ROI for KDE C2/TestMipping_cortex_b2_s1_c_4.tif'; % give sample snapshot image (blue DAPI)

input_image_prefix = 'O:\dRNA project\20x ROI for KDE C1/TestMipping_cortex_b1_s1_c_';%_ali_
flo_image = [input_image_prefix '4.tif']; % give sample snapshot image (blue DAPI)

output_image_prefix = [input_image_prefix,'_ali'];

%% original
ref = imread(ref_image);
size_ref = size(ref);
flo = imread(flo_image);
ref_resized = imresize(ref, 1);
%ref_resized=ref;
clear ref;
flo_resized = imresize(flo, 1);
%flo_resized=flo;
Ifuse = imfuse(ref_resized,flo_resized);
imshow(Ifuse);
% green: floating
% purple: reference

%% rotation
angle = 0; % positive: counter clockwise
[flo_rotate, Ifuse_rotate] = rotateimage(flo_resized, angle, ref_resized);
imshow(Ifuse_rotate);

%% translation
yup = 62;   % positive: move the floating image up, negative: down
xleft = 122;   % positive: move the floating image left, negative: right
Ifuse_translate = translateimage(yup, xleft, flo_rotate, ref_resized);
imshow(Ifuse_translate);
as=flo_rotate(yup+1:end,xleft+1:end);

%% transform images
%mkdir('D:\170717_schizo_CA1Probes\exported\1441-hippo\aligned\170717_mBrain_schizo_1441-hippo_b1');
tic
for c = 0:4
    original = imread([input_image_prefix num2str(c) '.tif']);
    as=original(yup+1:end,xleft+1:end);
    imwrite(as,[output_image_prefix num2str(c) '.tif'])
end
toc