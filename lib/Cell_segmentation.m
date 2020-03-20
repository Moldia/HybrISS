function [o, CellMap, DapiBoundaries] = segment_dapi(o, Dapi0)
% [0 CellMap BoundaryImage] = o.segment_dapi(DapiIm)
%
% segments a DAPI image and assigns each pixel to a cell. Input is
% optional, otherwise it will load from o.BigDapiFile
%
% only works within region outlined by o.CellCallRegionYX
%
% Output CellMap is same size as input DapiIm, with integer entries for
% each pixel, saying which cell it belongs to. (Zero if unassigned)
%
% also saved to o.CellMapFile

Dapi= imread('E:\Small_brain_SBH_automatic\withanchor\Tile844_cyc_5_CH_1_t844.tif');
%%
Dapi = imadjust(Dapi); % contrast enhancement
ImSz = size(Dapi);
Debug = 1;
%% threshold the map
%ThreshVal = prctile(Dapi(Mask), o.DapiThresh);

%bwDapi = imerode(Dapi>90, strel('disk', 2));
bwDapi = im2bw(Dapi,0.6);
if Debug
    figure(300)
    subplot(2,1,1);
    imagesc(Dapi); 
    subplot(2,1,2);
    imagesc(bwDapi);
    colormap bone
    %fprintf('Threshold = %f\n', ThreshVal);
    
end
%% find local maxima 
dist = bwdist(~bwDapi);
dist0 = dist;
dist0(dist<5)=0;
ddist = imdilate(dist0, strel('disk',7));
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
    image(label2rgb(CellMap, 'jet', 'w', 'shuffle'));

end

%%
% CellYX = fliplr(vertcat(rProps(BigEnough).Centroid)); % because XY

%% make image with boundaries
Boundaries = (CellMap ~= imdilate(CellMap,strel('disk', 1)));
DapiBoundaries = Dapi;

OddPix = mod((1:size(Dapi,2)) + (1:size(Dapi,1))', 2);
DapiBoundaries(Boundaries & OddPix) = .3 * max(Dapi(:));
DapiBoundaries(Boundaries & ~OddPix) = 0;

imwrite(DapiBoundaries, ['E:\Small_brain_SBH_automatic\withanchor\\background_boundaries.tif']);

o.CellMapFile = fullfile( 'E:\Small_brain_SBH_automatic\withanchor\CellMap.mat');
save(o.CellMapFile, 'CellMap', 'DapiBoundaries', 'y0', 'y1', 'x0', 'x1');


end
