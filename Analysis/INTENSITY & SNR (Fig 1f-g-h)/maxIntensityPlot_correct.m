%% script to find rcp and calculate intensity over rcps
% this version of the script relies on knowing the thresholds that you want
% to set. this can easily be figured out with using the original version of
% the script and testing it on some channel images. there is also work
%being done on trying to best optimize the thresholds.

% CML, 2020
close all
clear
%% user input
image_location = 'L:\4plex_assay\200313_r1c1\HalfCoronal/';
image_prefix = 'TestMipping';
% regions can denote parts of the brain for instance
region = {
    'ependymal'
    'hippo'
    'cortex'};
bases = {
    'b1'};
number_of_channels = 4;
num_bases = 1; %% change as necessary
num_scence = (1:2); % the number of slides
image_suffix = '.csv';
f_channel = { 
    'AF488'
    'AF750'
    'Cy5'
    'Cy3'
    };

%% fixing leica zero indexing
number_of_channels = number_of_channels-1;
%%
for ch = 0:number_of_channels
    for b = 1:length(bases)
        base = bases{b};
        IntensityData = [];
        for s = 1:length(num_scence)
            scence = num_scence(s);
            for r = 1:length(region)
                region_img = region{r};
                
                csv_file = [image_location, 's', num2str(scence), '_',num2str(ch), image_suffix];
                
                tabledata = readtable(csv_file);
                tabledata=tabledata(1:2000,:);
                REMOVEDOUTLIERS = rmoutliers(tabledata, 'grubbs');
                middlePixelIntensity = REMOVEDOUTLIERS.Var11;
                maximumIntensity = max(middlePixelIntensity, 50);
                
                if s == 1 
                    IntensityDataRNA = cat(1, IntensityData, maximumIntensity);
                    IntensityDataRNA_cell = num2cell(IntensityDataRNA);
                    IntensityDataRNA_mat = cell2mat(IntensityDataRNA_cell);
                    
                    % preparing the cell strings
                    length_IntensityData = length(IntensityDataRNA);
                    cell_length_IntensityData = cell((length_IntensityData),1);
                    names_RNA = strcat(cell_length_IntensityData, num2str(s), num2str(ch));
                    All_Cell_RNA = names_RNA;
                else

                    IntensityDatacDNA = cat(1, IntensityData, maximumIntensity);
                    IntensityDatacDNA_cell = num2cell(IntensityDatacDNA);
                    IntensityDatacDNA_mat = cell2mat(IntensityDatacDNA_cell);
                    
                    % preparing the cell strings
                    length_IntensityData = length(IntensityDatacDNA);
                    cell_length_IntensityData = cell((length_IntensityData),1);
                    names_cDNA = strcat(cell_length_IntensityData, num2str(s), num2str(ch));
                    All_Cell_cDNA = names_cDNA;
                end
            end
        end
    end
    
    All_Cell_RNAandcDNA = [IntensityDataRNA_mat; IntensityDatacDNA_mat];
    All_Cell_Names = [All_Cell_RNA; All_Cell_cDNA];
    
    width = 0.1;
    showmean = true;
    violinalpha = 0.3;
    
    subplot(2,2, ch+1);
    violinplot(All_Cell_RNAandcDNA, All_Cell_Names);
  
     sgt = sgtitle(['Maximum Intensity Cycle1'  ])
      sgt.FontSize = 30;
      
    title(strcat(' ', '   ', f_channel(ch+1)));
    ylabel('Intensity');
    ylim([0, 5500]);

end