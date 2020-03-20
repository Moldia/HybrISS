REAL='G:\Pseudoanchor test\DIPG_Sample15_1\Stitched2DTiles_MIST_Ref1\QT_0.5_details_noNNNN.csv';
PSEUDO='G:\Pseudoanchor test\DIPG_Sample15_1\Stitched2DTiles_MIST_Ref1\Pseudoanchor\QT_0.5_details_noNNNN.csv';
DAPI=imread('G:\Pseudoanchor test\DIPG_Sample15_1\Stitched2DTiles_MIST_Ref1\Base_1_stitched-5.tif');
PSEUDODAPI=imread('G:\Pseudoanchor test\DIPG_Sample15_1\Stitched2DTiles_MIST_Ref1\Pseudoanchor\Tile1_cyc_1_CH_6.tif');
realt=readtable(REAL);
pseudot=readtable(PSEUDO);
MERGE=imfuse(DAPI,PSEUDODAPI*3);
figure(23233);
imshow(MERGE*5);
hold on
scatter(realt.PosX,realt.PosY,'r');
hold on
scatter(pseudot.PosX,pseudot.PosY,'y');