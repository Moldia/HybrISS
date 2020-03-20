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
        Mean = [];
        Std = [];
        for s = 1:length(num_scence)
            scence = num_scence(s);
            for r = 1:length(region)
                region_img = region{r};
                
                csv_file = [image_location, 's', num2str(scence), '_',num2str(ch), image_suffix];
                
                tabledata = readtable(csv_file);
                %
                %                 REMOVEDOUTLIERS = rmoutliers(tabledata, 'grubbs');
                %                 REMOVEDOUTLIERS = table2array(REMOVEDOUTLIERS);
                %                 IntensityDataMean = mean(REMOVEDOUTLIERS, 1);
                %                 IntensityDataStd = std(REMOVEDOUTLIERS, 1);
                %
                %                 REMOVEDOUTLIERS = rmoutliers(tabledata, 'grubbs');
                
                
                
                if s == 1 && 2
                    tabledata_12 = table2array(tabledata);
                    IntensityDataMean_12 = mean(tabledata_12, 1);
                    IntensityDataStd_12 = std(tabledata_12, 1);

                    %IntensityData = cat(1, IntensityData, middlePixelIntensity);
                    IntensityDataMean_12 = cat(1, Mean, IntensityDataMean_12);
                    IntensityDataStd_12 = cat(1, Std, IntensityDataStd_12);
                else
                    tabledata_34 = table2array(tabledata);
                    IntensityDataMean_34 = mean(tabledata_34, 1);
                    IntensityDataStd_34 = std(tabledata_34, 1);

                    %IntensityData = cat(1, IntensityData, middlePixelIntensity);
                    IntensityDataMean_34 = cat(1, Mean, IntensityDataMean_34);
                    IntensityDataStd_34 = cat(1, Std, IntensityDataStd_34);
                end
            end
        end
    end
    co = [0.0 0.0 1.0;...
        1.0 0.0 0.0];
    set(groot,'defaultAxesColorOrder',co)
    sgt = sgtitle(['Average intensity Cycle1'  ]);
    sgt.FontSize = 30;
    subplot(2,2, ch+1);
    errorbar(IntensityDataMean_12, IntensityDataStd_12, 'MarkerSize',10,'MarkerEdgeColor','blue','MarkerFaceColor','blue')
    hold on
    errorbar(IntensityDataMean_34, IntensityDataStd_34, 'MarkerSize',10,'MarkerEdgeColor','red','MarkerFaceColor','red')
    tit = title([' ', f_channel(ch+1)]);
    tit.FontSize = 25;
     legend direct cdna
    ylab = ylabel('Intensity');
    ylab.FontSize = 20;
    ylim([0, 3000]);
    xlim([1,21])
end


