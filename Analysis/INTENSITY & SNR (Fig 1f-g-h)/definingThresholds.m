close all
image_location = 'L:\4plex_assay\200313_r1c1\200313_cDNA_01_tr2_r1c1_roi1_001\Preprocess\Stitched2DTiles_MIST_Ref1\';
image = '200313_cDNA_01_tr2_r1c1_roi1_001_stitched-4.tif';
image = [image_location, image];
I = imread(image);
threshold = 0.0038;
maxdist_between_spots = 14;
filename = [strtok(image, '.'), '.csv'];
% binary image
Ibw = im2bw(I, threshold); % Convert image to binary image, based on threshold val
figure, imshow(Ibw*20, []);
% find peaks
figure()
Idil = imdilate(I, ones(5)); % IMAGE DIALATION
centroid = I == Idil & Ibw;
[Y,X] = ind2sub(size(I), find(centroid));
figure; subplot(121);
imshow(I,[]);
hold on; plot(X, Y, 'r.');
% keep only isolated
idx = rangesearch([X,Y], [X,Y], maxdist_between_spots);
nNN = cellfun(@length, idx); % apply function to each cell in cell array
plot(X(nNN==1), Y(nNN==1), 'yo');
subplot(122); hold on;
bell_dist = 10;
fid = fopen(filename, 'w');
for i = find(nNN==1)'
    try
        plot(1:(2*bell_dist+1), I(Y(i),X(i)-bell_dist:X(i)+bell_dist) - min(I(Y(i),X(i)-bell_dist:X(i)+bell_dist)), 'k-');
        drawnow;
        fprintf(fid, lineformat('%d', 2*bell_dist+1), I(Y(i),X(i)-bell_dist:X(i)+bell_dist));
    end
end
fclose(fid);
i = find(nNN==1);
number_of_spots_inc = length(i);
function fmt = lineformat(vartype, repeat)
% fmt = lineformat(vartype, repeat)
% line format for csv file writing
% ends with newline character
% Xiaoyan, 2017
fmt = repmat([vartype, ','], 1, repeat);
fmt = [fmt(1:end-1), '\n'];
end