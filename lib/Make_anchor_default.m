PATH='I:\preprocessing\HCA11_2\fixing_format_for_starfish\Preprocessing\Stitched2DTiles_MIST_Ref1\';
OUTPATH='I:\preprocessing\HCA11_2\fixing_format_for_starfish\Preprocessing\Stitched2DTiles_MIST_Ref1\';
FILE_PREFIX='Base_';
FILE_SUFIX='.tif'
filenames={
    'Base_1_stitched-',
    'Base_2_stitched-',
    'Base_3_stitched-',
    'Base_4_stitched-',
    'Base_5_stitched-'
    

%     '190816_r1c1_SBL(2)-mip-stitched-Subset-01_1_c',
}

for tile = [1]
for cyc = 1:size(filenames)   

FILE_SUFIX=['.tif']    
FILE_PREFIX=strcat(filenames(cyc))
class(FILE_PREFIX)
FILE_PREFIX=char(FILE_PREFIX)
create_anchor (PATH,FILE_PREFIX, FILE_SUFIX,tile,cyc,OUTPATH)

end 
end
  

function create_anchor (PATH,FILE_PREFIX, FILE_SUFIX,tile,cyc,OUTPATH)
flodap = imread(strcat(PATH, FILE_PREFIX,'1',FILE_SUFIX));
flo1 = imread(strcat(PATH, FILE_PREFIX,'2',FILE_SUFIX));
flo2 = imread(strcat(PATH, FILE_PREFIX,'3',FILE_SUFIX));
flo3 = imread(strcat(PATH, FILE_PREFIX,'4',FILE_SUFIX));
flo4 = imread(strcat(PATH, FILE_PREFIX,'5',FILE_SUFIX));
 
 %% Tophat
 flo_top1= imtophat(flo1,strel('disk', 2));
 flo_top2= imtophat(flo2,strel('disk', 2));
 flo_top3= imtophat(flo3,strel('disk', 2));
 flo_top4= imtophat(flo4,strel('disk', 2));
 th=100;
 

anchor= flo_top1+flo_top2+flo_top3+flo_top4;
anchor_filt= imtophat(anchor,strel('disk', 2));
imwrite(flodap,strcat(OUTPATH,'Tile',num2str(tile),'_cyc_',num2str(cyc),'_CH_1',FILE_SUFIX))
imwrite(flo1,strcat(OUTPATH,'Tile',num2str(tile),'_cyc_',num2str(cyc),'_CH_2',FILE_SUFIX))
imwrite(flo2,strcat(OUTPATH,'Tile',num2str(tile),'_cyc_',num2str(cyc),'_CH_4',FILE_SUFIX))
imwrite(flo3,strcat(OUTPATH,'Tile',num2str(tile),'_cyc_',num2str(cyc),'_CH_5',FILE_SUFIX))
imwrite(flo4,strcat(OUTPATH,'Tile',num2str(tile),'_cyc_',num2str(cyc),'_CH_3',FILE_SUFIX))
imwrite(anchor_filt, strcat(OUTPATH,'Tile',num2str(tile),'_cyc_',num2str(cyc),'_CH_0',FILE_SUFIX));
end
 
 