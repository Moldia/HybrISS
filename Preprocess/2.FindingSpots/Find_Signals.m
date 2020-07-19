function [SIG1]=Find_Signals(Itop,Threshold,num)
% %% reference segmentation
I = double(Itop)/65535;
I=Itop;
I = imtophat(I, strel('disk', 2));

ok='NO';

Ibw = im2bw(I, Threshold); %This value needs to be customized
drawnow;
figure;
subplot(1,2,1);
imshow(Itop*50);
subplot(1,2,2);
imshow(Ibw*100);
linkaxes();



Iws = watershed(-I);
Iws = double(Iws) .* double(Ibw);
Ibw = logical(Iws);
Ibw = bwareaopen(Ibw, 3);
Ibw = logical(Iws);
SIG1=Ibw;

end