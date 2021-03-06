function [inbin, bincenters,hexbel] = hexbin_near_spots(pos, radius,distx,disty,name)
% [inbin, bincenters, vx, vy] = hexbin(pos, radius)
% hexagonal binning
% Xiaoyan, 2017

%% hexagon center and vertex coordinates
% distance between centers


% hexagon centers
%[cx, cy] = [pos(:,1), pos(:,2)];
posini=pos;
cx=pos(:,1)';
cy=pos(:,2)';
    
%pos=[cx',cy'];
% vertex coordinates
%[vy, vx] = dot2poly(cy',cx', radius, 6);
vx=[cx'-radius,cx'+radius,cx'-radius,cx'+radius]';
vy=[cy'-radius,cy'-radius,cy'+radius,cy'+radius]';

%% bin counts
inbin = []; %Include genes assigned to hex
hexbel=[];
counted = false(size(posini,1),1);

% count spots within a hexagon
for i = 1:size(cx,2)
    disp(i)
    in = inpolygon(posini(:,1), posini(:,2), vx(:,i), vy(:,i));
    %in = posini(in);%& ~counted;
    inbin=[inbin,repmat(i,1,sum(in))];
    hexbel=[hexbel,name(in)'];
    %counted= counted | in;
end

% remove empty bins
bincenters = [cx(unique(inbin));cy(unique(inbin))]';
hexbel=hexbel';
inbin=inbin';
%vx = vx(:,unique(inbin(~ismember(inbin,[0:1]),:)));
%vy = vy(:,unique(inbin(~ismember(inbin,[0:1]),:)));

end
