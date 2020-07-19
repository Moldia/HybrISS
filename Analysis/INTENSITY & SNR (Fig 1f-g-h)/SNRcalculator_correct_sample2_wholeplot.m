close all
clear
%% user input
image_location = 'L:\4plex_assay\200313_r1c1\rois_1st/';
image_prefix = 'dRNA';
% regions can denote parts of the brain for instance
region = {
    'dRNA_02_tr4_r1c1_ROI2_001_stitched-'
    'dRNA_02_tr4_r1c1_ROI3_001_stitched-'
    '200313_dRNA_02_tr4_r1c1_ROI1001_stitched-'
     'dRNA_01_tr1_r1c1_ROI2_001_stitched-'
    'dRNA_01_tr1_r1c1_ROI3_001_stitched-'
    '200313_dRNA_01_tr1_r1c1_roi1_001_stitched-'
'200313_dRNA_02_tr3_r1c1_ROI1001_stitched-'
    'cDNA_02_tr3_r1c1_ROI2_001_stitched-'
    'cDNA_02_tr3_r1c1_ROI3_001_stitched-'
     '200313_cDNA_01_tr2_r1c1_roi1_001_stitched-'
    'cDNA_01_tr2_r1c1_ROI2_001_stitched-'
    'cDNA_01_tr2_r1c1_ROI3_001_stitched-'
   
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
SNR_121=[];
SNR_122=[];
SNR_341=[];
SNR_342=[];
CAT=[];
%% fixing leica zero indexing
number_of_channels = number_of_channels-1;
%%
VEC=[];
for ch = 1:number_of_channels
    SNR_12=[];
SNR_34=[];
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
                if r==1 | r==2 | r==3
                          SNR_121 = [SNR_121;SNR];
                end
                if r==4 | r==5 | r==6
                          SNR_122 = [SNR_122;SNR];
                end
                if r==7 | r==8 | r==9
                          SNR_341 = [SNR_341;SNR];
                end
                if r==10 | r==11 | r==12
                          SNR_342 = [SNR_342;SNR];
                end
       
            end
        end
    end
    SNR_121=mean(SNR_121);
    SNR_122=mean(SNR_122);
    SNR_341=mean(SNR_341);
    SNR_342=mean(SNR_342);
    MAX1=max(SNR_121);
    MAX2=max(SNR_122);
    MAX3=max(SNR_341);
    MAX4=max(SNR_342);
    CAT=[CAT;MAX1,MAX2,MAX3,MAX4];
     subplot(2,2, ch);
    plot(SNR_121, 'MarkerSize',10,'MarkerEdgeColor','red','MarkerFaceColor','red','Color','blue')
     sgt = sgtitle(['Signal to Noise Ratio (SNR) Cycle1'  ])
      sgt.FontSize = 30;
    hold on
     plot(SNR_122, 'MarkerSize',10,'MarkerEdgeColor','red','MarkerFaceColor','red','Color','blue')
    hold on
    plot(SNR_341, 'MarkerSize',10,'MarkerEdgeColor','red','MarkerFaceColor','red','Color','red')
    hold on  
    plot(SNR_342, 'MarkerSize',10,'MarkerEdgeColor','red','MarkerFaceColor','red','Color','red')
    title(strcat(' ', '   ', f_channel(ch)));
    legend direct direct cdna cdna
    xlabel ('Pixel number')
    ylabel ('Signal to noise ratio')
    ax = gca;
    ax.FontSize = 12;
    xlim([1 21])
    ylim([1 9])
   
end


