
function CellSegmentationInMatlab(folder,PREFIX,INTERFIX,SUFIX,TYPE,tiles,outputdirect,ncyc,num_pixels)

% ISS image analysis workshop, 170614
% Xiaoyan
% tested on MATLAB R2016b


tiltot=[];

%%%%%%%%%%%%%%%%%THIS VISUALIZES INFORMATION%%%%%%%%%%%%%%%%

% % write image and prepare CP input file
% for b = 1:4
%     for c = 1:6
%         I = Imip{b,c};
%         imwrite(I, ['b' num2str(b) '_c' num2str(c) '.tif']);
%     end
% end
% writeposfile('b1_c1.tif', 600, 1:4, 1:6, [1,2], 'b', '_c', '', '');

%% sequencing images
% figure
%%%%%%%%%%%%%%CREATE A BIG OBJECT AND WORKING%%%%%%%%%%%%%%%%%%%%%%%%
combinattot=[];
for tile = 1:tiles
disp(['Analizing tile ',num2str(tile)])
A={};
ATOT={};
%AUTOMATE
for b = 1:ncyc
    for c = 1:1
        TOTAL=[folder,PREFIX,num2str(tile),INTERFIX,num2str(b),SUFIX,num2str(c),'_t',num2str(tile),TYPE];
        tot=imread(TOTAL);
        if c ~= 1
            A=cat(3,A,tot);
        else 
            A=tot;
        end
       
    end
    if b ~= 1
       ATOT=cat(4,ATOT,A);
        else 
            ATOT=A;
    end
end

disp('Passed');

Dapi = ATOT(:,:,1,1);
Dapi = imadjust(Dapi); % contrast enhancement
ImSz = size(Dapi);
Debug = 1;
%% threshold the map
%ThreshVal = prctile(Dapi(Mask), o.DapiThresh);

%bwDapi = imerode(Dapi>90, strel('disk', 2));
bwDapi = im2bw(Dapi,0.6);
% if Debug
%     figure(300)
%     subplot(2,1,1);
%     imagesc(Dapi); 
%     subplot(2,1,2);
%     imagesc(bwDapi);
%     colormap bone
%     %fprintf('Threshold = %f\n', ThreshVal);
%     
% end

%% find local maxima 
dist = bwdist(~bwDapi);
dist0 = dist;
dist0(dist<5)=0;
ddist = imdilate(dist0, strel('disk',7));
%clear dist 
impim = imimposemin(-dist0, imregionalmax(ddist));
clear dist0
% if Debug
%     figure(301);
%     subplot(2,1,1)
%     imagesc(dist);
%     subplot(2,1,2)
%     imagesc(impim);
% end
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
Debug=1;
% if Debug
%     figure(302)
%     image(label2rgb(CellMap, 'jet', 'w', 'shuffle'));
% end
%%
% CellYX = fliplr(vertcat(rProps(BigEnough).Centroid)); % because XY

%% make image with boundaries
Boundaries = (CellMap ~= imdilate(CellMap,strel('disk', 1)));
DapiBoundaries = Dapi;

OddPix = mod((1:size(Dapi,2)) + (1:size(Dapi,1))', 2);
DapiBoundaries(Boundaries & OddPix) = .3 * max(Dapi(:));
DapiBoundaries(Boundaries & ~OddPix) = 0;

%imshow(DapiBoundaries);
%pause();
labels=unique(CellMap);
labels=find(labels>0);
for S=1:size(labels,1);
   X=labels(S);
   [un,dos]=find(CellMap==X);
   v=X+zeros(size(un,1),1);
   ti=tile+zeros(size(un,1),1);
   til=[un,dos,v,ti];
    if size(tiltot,1)==0;
    tiltot=til;
    else
    tiltot=[tiltot;til];
    end
end

%imwrite(DapiBoundaries, ['E:\Small_brain_SBH_automatic\withanchor\\background_boundaries.tif']);

end

disp('Tiltot is');

writematrix(tiltot,[folder,'/cells.csv']);


end