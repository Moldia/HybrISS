%% align a floating image on top of a reference image
%  need to give rotation angle and translation matrix


%% input
ref_image = 'O:\dRNA project\20x ROI for KDE C1/Tile1_cyc_1_CH_6m1_ORG.tif'; % give sample snapshot image (blue DAPI)
flo_image = 'H:/hm_brain_SBH_small/anchor/Tile1_cyc_2_CH_6m1_ORG.tif'; % give sample snapshot image (blue DAPI)
flo_position_matfile = 'E:\PROOOJECTS\9_Ephrin\Image analysis\11692_A3_A5\11692_2_2\ImageAnalysis.mat'; % mat file containing floating image positions

output_name_ref = 'aligned_11692_2_1.png';  %.png format
output_name_flo = 'aligned_11692_2_2.png';  %.png format
output_position_filename = '11692_2_2_registered.csv'; % .csv format

%% reference image
ref = imread(ref_image);
ref = ref(:,:,3);
ref = imresize(ref,.4);
imwrite(ref,output_name_ref);

%% floating image
[ref,flo,original,Ifuse] = readimages_f(output_name_ref,0,.5,...
    flo_image,1,.2);
imshow(Ifuse);
% green: floating
% purple: reference

%% rotation
angle = 0; % positive: counter clockwise
[flo_rotate,Ifuse_rotate] = rotateimage_f(flo,angle,ref);
imshow(Ifuse_rotate);

%% translation
yup = 10;   % positive: move the floating image up, negative: down
xleft = 1;   % positive: move the floating image left, negative: right
Ifuse_translate = translateimage_f(yup,xleft,flo_rotate*100,ref*100);
imshow(Ifuse_translate);

%% update positions
new_pos = transformpositions_f(flo_position_matfile,angle,yup,xleft,flo_rotate,ref);

fid = fopen(output_position_filename,'w');
fprintf(fid,'x_pos,y_pos,size,channel\n');
fprintf(fid,'%d,%d,%d,%d\n',new_pos');
fclose(fid);

%% transform image
transformimage_f(original,output_name_ref,angle,yup,xleft,output_name_flo,new_pos)