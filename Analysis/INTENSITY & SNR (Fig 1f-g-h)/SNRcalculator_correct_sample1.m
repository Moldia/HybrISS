close all
clear
%% user input
image_location = 'L:\4plex_assay\200313_r1c1\rois_1st/';
image_prefix = 'dRNA';
% regions can denote parts of the brain for instance
region = {
    '200313_cDNA_01_tr2_r1c1_roi1_001_stitched-'
    'cDNA_01_tr2_r1c1_ROI2_001_stitched-'
    'cDNA_01_tr2_r1c1_ROI3_001_stitched-'
    'dRNA_01_tr1_r1c1_ROI2_001_stitched-'
    'dRNA_01_tr1_r1c1_ROI3_001_stitched-'
    '200313_dRNA_01_tr1_r1c1_roi1_001_stitched-'
    };
bases = {
    'b1'};
number_of_channels = 5;
num_bases = 1; %% change as necessary
num_scence = (1:2); % the number of slides
image_suffix = '.csv';
f_channel = { 
'AF750'    
'Cy5'
'Cy3'
'AF488'
    };

%% fixing leica zero indexing
number_of_channels = number_of_channels-1;
%%
VEC=[];
for ch = 1:number_of_channels
    for b = 1:length(bases)
       base = bases{b};
        Mean = [];
        Std = [];
        for s = 1:length(num_scence)
            scence = num_scence(s);
            for r = 1:length(region)
                region_img = region{r};
                
                csv_file = [image_location,region_img,num2str(ch), image_suffix];
                
                tabledata = readtable(csv_file);
                arraydata = table2array(tabledata, 'grubbs');
                
                % finding the mean signal
                signalmean = mean(arraydata, 1);
                
                % calculating the mean background
                backgroundPos1 = (signalmean (:,1));
                backgroundPos2 = (signalmean (:,2));
                backgroundPos3 = (signalmean (:,20));
                backgroundPos4 = (signalmean (:, 21));
                backgroundmean = ((backgroundPos1+backgroundPos2+backgroundPos3+backgroundPos4)/4);
                
                % calculating the signal to noise ratio
                SNR = signalmean/backgroundmean;
                
                
                if r == 1 
                    SNR_12 = SNR;
                end
                 if r == 2  | r==3
                     SNR_12 = [SNR_12,SNR];
                 end    
                if r==4
                    SNR_34 = SNR;
                end
                 if r==5  | r==6 
                    SNR_34=[SNR_34,SNR];
                 end
            end
        end
    end
    VEC=[VEC;max(SNR_12),max(SNR_34)]
   
end

figure
bar(categorical(f_channel),VEC)

MAXVA{1}=categorical(f_channel);
MAXVA{2}=VEC;

