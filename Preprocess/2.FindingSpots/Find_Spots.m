function [SIG1]=Find_Spots(Itop,Threshold,num)
% %% reference segmentation
I = double(Itop)/65535;
I=Itop;
I = imtophat(I, strel('disk', 2));
% 
% ok='NO';
% 
% while strcmp(ok,'NO')
 Ibw = im2bw(I, Threshold); %This value needs to be customized
drawnow;
figure;
subplot(1,2,1);
imshow(Itop*50);
subplot(1,2,2);
imshow(Ibw*100);
linkaxes();
% prompt = 'It it ok?';
% ok=input(prompt)
% if strcmp(ok,'NO')
% prompt = 'Define new threshold';
% Threshold = input(prompt)
% end
% end


Iws = watershed(-I);
Iws = double(Iws) .* double(Ibw);
Ibw = logical(Iws);
Ibw = bwareaopen(Ibw, 3);
Ibw = logical(Iws);

UNIQUES = bwconncomp(Iws);
U2=labelmatrix(UNIQUES);
%U2=uint16(U2);
pr=regionprops(U2);
XY=fliplr(vertcat(regionprops(U2).Centroid));
SELECTION=vertcat(pr.Area)>2 & vertcat(pr.Area)<20;
 [blobs] = unique(U2);
 blobs = blobs(blobs~=0);
 size(blobs)

 SIG1=[blobs,XY];
 SIG1=SIG1(SELECTION,:);
 GROUP=num*ones(size(SIG1,1),1);
 SIG1=[SIG1,GROUP];

end