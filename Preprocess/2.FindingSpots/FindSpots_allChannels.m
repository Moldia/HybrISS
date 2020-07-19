% Designed by Sergio Marco Salas in Nilsson's lab, March 2020
% tested on MATLAB R2019b


folder='L:\4plex_assay\200313_r1c1\OUT\Preprocess\Stitched2DTiles_MIST_Ref1\'
PREFIX='200311_dRNA_01_rd1cy1001_stitched-'


Itop=imread([folder,PREFIX,num2str(1),'.tif']);
% %% reference segmentation
I = double(Itop)/65535;
I=Itop;
I = imtophat(I, strel('disk', 2));
Ibw = im2bw(I, 0.001);
figure(2323);
subplot(1,2,1);
imshow(Itop*100);
subplot(1,2,2);
imshow(Ibw*100);
linkaxes();


Iws = watershed(-I);
Iws = double(Iws) .* double(Ibw);
Ibw = logical(Iws);
Ibw = bwareaopen(Ibw, 3);
image(Iws);
Ibw = logical(Iws);

UNIQUES = bwconncomp(Iws);
U2=labelmatrix(UNIQUES);
U2=uint16(U2);
pr=regionprops(U2);
XY=fliplr(vertcat(regionprops(U2).Centroid));

 [blobs] = unique(U2);
 blobs = blobs(blobs~=0);
 size(blobs)

 SIG0=[blobs,XY];
 GROUP=0*ones(size(SIG0,1),1);
 SIG0=[SIG0,GROUP];
 
 %%%%%%%%%%%%SIG2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
Itop=imread([folder,PREFIX,num2str(2),'.tif']);
% %% reference segmentation
I = double(Itop)/65535;
I = imtophat(I, strel('disk', 2));
Ibw = im2bw(I, 0.0025);
imshow(Ibw);
Iws = watershed(-I);
Iws = double(Iws) .* double(Ibw);
Ibw = logical(Iws);
Ibw = bwareaopen(Ibw, 3);
image(Iws);
Ibw = logical(Iws);


figure;
subplot(1,2,1);
imshow(Itop*7);
subplot(1,2,2);
imshow(Ibw*100);
linkaxes();

UNIQUES = bwconncomp(Iws);
U2=labelmatrix(UNIQUES);
%U2=uint16(U2);
pr=regionprops(U2);
sa=vertcat(pr.Centroid);
XY=fliplr(vertcat(pr.Centroid));

[blobs] = unique(U2);
blobs = blobs(blobs~=0);
size(blobs)

SIG1=[blobs,XY];
GROUP=1*ones(size(SIG1,1),1);
SIG1=[SIG1,GROUP];
 

%%%%% SIG2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Itop=imread([folder,PREFIX,num2str(3),'.tif']);
% %% reference segmentation
I = double(Itop)/65535;
I = imtophat(I, strel('disk', 2));
Ibw = im2bw(I, .001);
imshow(Ibw);
Iws = watershed(-I);
Iws = double(Iws) .* double(Ibw);
Ibw = logical(Iws);
Ibw = bwareaopen(Ibw, 3);
image(Iws);
Ibw = logical(Iws);



figure(2222);
subplot(1,2,1);
imshow(Itop*90);
subplot(1,2,2);
imshow(Ibw*100);
linkaxes();


UNIQUES = bwconncomp(Iws);
U2=labelmatrix(UNIQUES);
%U2=uint16(U2);
 blobs = unique(U2);
 blobs = blobs(blobs~=0);
 size(blobs)
pr=regionprops(U2);
XY=fliplr(vertcat(regionprops(U2).Centroid));

 [blobs] = unique(U2);
 blobs = blobs(blobs~=0);
 size(blobs)

 SIG2=[blobs,XY];

 GROUP=2*ones(size(SIG2,1),1);
 SIG2=[SIG2,GROUP];
 
 
  
%%%%% SIG3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 Itop=imread([folder,PREFIX,num2str(4),'.tif']);
% %% reference segmentation
I = double(Itop)/65535;
I = imtophat(I, strel('disk', 2));
Ibw = im2bw(I, .002);
imshow(Ibw);
Iws = watershed(-I);
Iws = double(Iws) .* double(Ibw);
Ibw = logical(Iws);
Ibw = bwareaopen(Ibw, 3);
image(Iws);
Ibw = logical(Iws);



figure(2323);
subplot(1,2,1);
imshow(Itop*200);
subplot(1,2,2);
imshow(Ibw*100);
linkaxes();


UNIQUES = bwconncomp(Iws);
U2=labelmatrix(UNIQUES);
%U2 = uint16(U2);
 blobs = unique(U2);
 blobs = blobs(blobs~=0);
 size(blobs);
 pr=regionprops(U2);
XY=fliplr(vertcat(regionprops(U2).Centroid));

 [blobs] = unique(U2);
 blobs = blobs(blobs~=0);
 size(blobs)

 SIG3=[blobs,XY];
 GROUP=3*ones(size(SIG3,1),1);
 SIG3=[SIG3,GROUP];
 
 
 
 ALL=[SIG0(:,1:4);SIG1(:,1:4);SIG2(:,1:4);SIG3(:,1:4)];
 writematrix(ALL,['O:\dRNA project\mipped C1 full scan 20x\',PREFIX,'.csv']);
 
 
 
 
 
 
 
 
 
 %WORKING WITH DAPI

IDAPI=imread([folder,PREFIX,num2str(4),'.tif']);

Dapi = imadjust(IDAPI); % contrast enhancement
ImSz = size(Dapi);
Debug = 1;
%% threshold the map
ThreshVal = 35000;

bwDapi = imerode(Dapi>ThreshVal, strel('disk', 2));

if Debug
    figure(300)
    subplot(2,1,1);
    imagesc(Dapi); 
    subplot(2,1,2);
    imagesc(bwDapi);
    colormap bone
    fprintf('Threshold = %f\n', ThreshVal);
    linkaxes();
end
%% find local maxima 
dist = bwdist(~bwDapi);
dist0 = dist;
dist0(dist<5)=0;


ddist = imdilate(dist0, strel('disk', 7));
%clear dist 
impim = imimposemin(-dist0, imregionalmax(ddist));
clear dist0
if Debug
    figure(301);
    subplot(2,1,1)
    imagesc(dist);
    subplot(2,1,2)
    imagesc(impim);
end
%% segment
% remove pixels at watershed boundaries
bwDapi0 = bwDapi;
bwDapi0(watershed(impim)==0)=0;

% assign all pixels a label
labels = uint32(bwlabel(bwDapi0));
[d, idx] = bwdist(bwDapi0);

% now expand the regions by a margin
CellMap0 = zeros(ImSz, 'uint32');
Expansions = (d<10);
CellMap0(Expansions) = labels(idx(Expansions));

% get rid of cells that are too small
rProps0 = regionprops(CellMap0); % returns XY coordinate and area
BigEnough = [rProps0.Area]>200;
NewNumber = zeros(length(rProps0),1);
NewNumber(~BigEnough) = 0;
NewNumber(BigEnough) = 1:sum(BigEnough);
CellMap = CellMap0;
CellMap(CellMap0>0) = NewNumber(CellMap0(CellMap0>0));

if Debug
    figure(302)
    subplot(1,2,1);
    image(label2rgb(CellMap, 'jet', 'w', 'shuffle'));
    subplot(1,2,2);
    imshow(Dapi);
    linkaxes();
end

%%

%UNIQUES = bwconncomp(Ibw);
U2=CellMap;
 blobs = unique(U2);
 blobs = blobs(blobs~=0);
 size(blobs)
 XtotD=[];
 YtotD=[];
 Position0=[];
 Position1=[];
 Position2=[];
 Position3=[];
 SIZE=[];
 for totblob = 1:size(blobs)
 disp(totblob)
 [X,Y]=find(U2==blobs(totblob));
 XtotD=[XtotD,mean(X)];
 YtotD=[YtotD,mean(Y)];
 SIZE=[SIZE,size(X,1)];
 Position0=[Position0,sum(ismember(SIG0(:,2),X)& ismember(SIG0(:,3),Y))];
 Position1=[Position1,sum(ismember(SIG1(:,2),X)& ismember(SIG1(:,3),Y))];
 Position2=[Position2,sum(ismember(SIG2(:,2),X)& ismember(SIG2(:,3),Y))];
 Position3=[Position3,sum(ismember(SIG3(:,2),X)& ismember(SIG3(:,3),Y))];
 end

SIGdapi=[blobs,XtotD',YtotD',Position0',Position1',Position2',Position3',SIZE']; 
scatter(XtotD,YtotD,10,Position2,'filled');
figure(1211);
SIGdapiSEL=SIGdapi(Position1>0 & Position1<5,:);
scatter(SIGdapiSEL(:,2),SIGdapiSEL(:,3),10,SIGdapiSEL(:,4),'filled');
colormap(jet(20))
%IDAPI
 

figure(12)
imshow(IDAPI);
hold on 
scatter(SIG0(:,3),SIG0(:,2),1,'r','filled')
hold on
scatter(SIG1(:,3),SIG1(:,2),1,'b','filled')
hold on
scatter(SIG2(:,3),SIG2(:,2),1,'g','filled')
 hold on
scatter(SIG3(:,3),SIG3(:,2),1,'y','filled')
 









%%%%%%%%%%%%%%%%%HEATMAP%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%rea
exp=readmatrix(['O:\dRNA project\20x ROI for KDE C1\',PREFIX,'.csv']);
exp1=exp(exp(:,4)==1,:); 
exp2=exp(exp(:,4)==2,:); 
exp3=exp(exp(:,4)==3,:); 
exp0=exp(exp(:,4)==0,:); 
 

%%
for i =0:3;
scale = 1;      % image scale
gene_density = num2str(i);
bandwid = 60;   % in original scale

name=cellstr(num2str(exp(:,4)));
%name=name';
pos=exp(:,[3,2]);
%pos=pos';
% density estimation plot
density = gene_kde(name, pos, gene_density, bandwid, [folder,PREFIX,num2str(i),'.tif'], scale);
figure;
imshow(density, []);
colormap(gca, colormap2);
title(gene_density);

print([folder,PREFIX,gene_density,'_heatmap'],'-dsvg')


end




 
 