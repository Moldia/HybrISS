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
VEC=[];
for ch = 1:number_of_channels
    for b = 1:length(bases)
        base = bases{b};
        IntensityDataRNA = [];
        IntensityDatacDNA =[];
        for s = 1:length(num_scence)
            scence = num_scence(s);
            for r = 1:length(region)
                region_img = region{r};
                
                csv_file = [image_location,region_img,num2str(ch), image_suffix];
                
                tabledata = readtable(csv_file);
                tabledata=sortrows(tabledata,11,'descend');
                if size(tabledata,1)>50
                tabledata=tabledata(1:50,:);
                else
                tabledata=tabledata(:,:); 
                end
                REMOVEDOUTLIERS = rmoutliers(tabledata, 'grubbs');
                middlePixelIntensity = REMOVEDOUTLIERS.Var11;
                maximumIntensity = max(middlePixelIntensity, 50);
                
                if r== 1  | r==2  | r==3 | r== 4  | r==5  | r==6 
                    
                    IntensityDataRNA = vertcat(IntensityDataRNA, maximumIntensity);
                    IntensityDataRNA_cell = num2cell(IntensityDataRNA);
                    IntensityDataRNA_mat = cell2mat(IntensityDataRNA_cell);
                    
                    % preparing the cell strings
                    length_IntensityData = length(IntensityDataRNA);
                    cell_length_IntensityData = cell((length_IntensityData),1);
                    names_RNA = strcat(cell_length_IntensityData, num2str(r), num2str(ch));
                    All_Cell_RNA = names_RNA;
                end
                if  r== 7  | r==8  | r==9 | r== 10  | r==11  | r==12
                    IntensityDatacDNA = vertcat(IntensityDatacDNA, maximumIntensity);
                    IntensityDatacDNA_cell = num2cell(IntensityDatacDNA);
                    IntensityDatacDNA_mat = cell2mat(IntensityDatacDNA_cell);
                    
                    % preparing the cell strings
                    length_IntensityData = length(IntensityDatacDNA);
                    cell_length_IntensityData = cell((length_IntensityData),1);
                    names_cDNA = strcat(cell_length_IntensityData, num2str(r), num2str(ch));
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
     if ch==3
             disp(ch)
     end
    subplot(2,2, ch);
    violinplot(All_Cell_RNAandcDNA, All_Cell_Names);
  
     sgt = sgtitle(['Maximum Intensity Cycle1'  ])
      sgt.FontSize = 30;
      
    title(strcat(' ', '   ', f_channel(ch)));
    ylabel('Intensity');
    ylim([0, 5500]);

end