function [inbin, bincenters, vx, vy] = hexbin_smallsize(pos, radius)
% [inbin, bincenters, vx, vy] = hexbin(pos, radius)
% hexagonal binning
% Xiaoyan, 2017

%% hexagon center and vertex coordinates
% distance between centers


% hexagon centers
%[cx, cy] = [pos(:,1), pos(:,2)];

cx=pos(:,1);
cy=pos(:,2);


% vertex coordinates
[vy, vx] = dot2poly(cy, cx, radius, 6);


%% bin counts
inbin = zeros(size(pos,1),1);
counted = false(size(pos,1),1);

% count spots within a hexagon
for i = 1:length(cx)
    disp(i)
    in = inpolygon(pos(:,1), pos(:,2), vx(:,i), vy(:,i));
    in = in & ~counted;
    counted = counted | in;
    inbin(in) = i;
end

% remove empty bins
bincenters = pos(unique(inbin(~ismember(inbin,0),:)),:);
vx = vx(:,unique(inbin(~ismember(inbin,0),:)));
vy = vy(:,unique(inbin(~ismember(inbin,0),:)));

end
