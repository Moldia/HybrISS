%% script to find rcp and calculate intensity over rcps
% this version of the script relies on knowing the thresholds that you want
% to set. this can easily be figured out with using the original version of
% the script and testing it on some channel images. there is also work
%being done on trying to best optimize the thresholds.

% CML, 2020
close all
clear
%% user input

number_of_channels = 5;
image_location = 'O:\dRNA project\CYCLE 2\Preprocess\Stitched2DTiles_MIST_Ref1\';
image_prefix = ''; 
% regions can denote different slides for instance 
region = {
    'tr1-1_stitched-'
    'tr1-2_stitched-'
    'tr1-3_stitched-'
    'tr2-1_stitched-'
    'tr2-2_stitched-'
    'tr2-3_stitched-'
    'tr3-1_stitched-'
    'tr3-2_stitched-'
    'tr3-3_stitched-'
    'tr4-1_stitched-'
    'tr4-2_stitched-'
    'tr4-3_stitched-'};
bases = {
    'b1'};
threshold_all_channels = [0.01,0.02,.05,.03];
num_bases = 1;
num_scence = (1); % the number of slides
image_suffix = '.tif';
number_of_channels = number_of_channels-1;

%%
for s = 1:length(num_scence)
    scence = num_scence(s);
    for r = 1:length(region)
        region_img = region{r};
        for b = 1:length(bases)
            base = bases{b};
            for ch = 1:number_of_channels
                disp(ch)
                if ch == 1 % this has to be tested beforehand
                    channel = 1;
                    threshold = threshold_all_channels(1);
                elseif ch == 2
                    channel = 2;
                    threshold = threshold_all_channels(2);
                elseif ch == 3
                    channel = 3;
                    threshold = threshold_all_channels(3);
                else
                    channel = 4;
                    threshold = threshold_all_channels(4);
                end
                
                image = [image_location, image_prefix,region_img,num2str(ch),image_suffix];
                
                I = imread(image);
                
                maxdist_between_spots = 14;
                filename = [strtok(image, '.'), '.csv'];
                % binary image
                Ibw = im2bw(I, threshold); % Convert image to binary image, based on threshold
                figure, imshow(Ibw, []);
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
                        disp(i);
                        plot(1:(2*bell_dist+1), I(Y(i),X(i)-bell_dist:X(i)+bell_dist) - min(I(Y(i),X(i)-bell_dist:X(i)+bell_dist)), 'k-');
                        drawnow;
                        fprintf(fid, lineformat('%d', 2*bell_dist+1), I(Y(i),X(i)-bell_dist:X(i)+bell_dist));
                    end
                end
                fclose(fid);
                
              
                
               
            end
        end
    end
    
end

function fmt = lineformat(vartype, repeat)
% fmt = lineformat(vartype, repeat)
% line format for csv file writing
% ends with newline character
% Xiaoyan, 2017
fmt = repmat([vartype, ','], 1, repeat);
fmt = [fmt(1:end-1), '\n'];
end

