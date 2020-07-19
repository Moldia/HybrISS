              % CML, 2020
close all
clear
%% user input
image_location = 'O:\dRNA project\CYCLE1_2\Preprocess\Stitched2DTiles_MIST_Ref1/';
image_prefix = 'dRNA';
% regions can denote parts of the brain for instance
region = {
    '200414 drna roi 20x_MIPPED_sample1_tr1_stitched-'
    '200414 drna roi 20x_MIPPED_sample2_tr1_stitched-'
     '200414 drna roi 20x_MIPPED_sample3_tr1_stitched-'
    '200414 drna roi 20x_MIPPED_sample2_tr4_stitched-'
   '200414 drna roi 20x_MIPPED_sample1_tr4_stitched-'
   '200414 drna roi 20x_MIPPED_sample3_tr4_stitched-'
     '200414 drna roi 20x_MIPPED_sample1_tr2_stitched-'
      '200414 drna roi 20x_MIPPED_sample2_tr2_stitched-'
        '200414 drna roi 20x_MIPPED_sample3_tr2_stitched-'
    '200414 drna roi 20x_MIPPED_sample1_tr3_stitched-'
    '200414 drna roi 20x_MIPPED_sample3_tr3_stitched-'
    '200414 drna roi 20x_MIPPED_sample2_tr3_stitched-'
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
                %
                %                 REMOVEDOUTLIERS = rmoutliers(tabledata, 'grubbs');
                %                 REMOVEDOUTLIERS = table2array(REMOVEDOUTLIERS);
                %                 IntensityDataMean = mean(REMOVEDOUTLIERS, 1);
                %                 IntensityDataStd = std(REMOVEDOUTLIERS, 1);
                %
                %                 REMOVEDOUTLIERS = rmoutliers(tabledata, 'grubbs');
                
                
                
                if r <7
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
    subplot(2,2, ch);
    errorbar(IntensityDataMean_12, IntensityDataStd_12, 'MarkerSize',10,'MarkerEdgeColor','blue','MarkerFaceColor','blue')
    hold on
    errorbar(IntensityDataMean_34, IntensityDataStd_34, 'MarkerSize',10,'MarkerEdgeColor','red','MarkerFaceColor','red')
    tit = title([' ', f_channel(ch)]);
    tit.FontSize = 25;
     legend direct cdna
    ylab = ylabel('Intensity');
    ylab.FontSize = 20;
    ylim([0, 3000]);
    xlim([1,21])
end


