function Cross_talk(blobs,out_fold)

taglist = importdata(blobs);
data=taglist.textdata;
data=cell2table(data);
data.data1 = char(data.data1);
data.data2 = char(data.data2);
data.data3 = char(data.data3);
data.data4 = char(data.data4);
data.data5 = char(data.data5);
data.data6 = char(data.data6);
data.data7 = char(data.data7);
data.data8 = char(data.data8);
data.data9 = char(data.data9);
data.data10 = char(data.data10);
data.data11 = char(data.data11);
data.data1 = str2double(data.data1);
data.data2 = str2double(data.data2);
data.data3 = str2double(data.data3);
data.data4 = str2double(data.data4);
data.data5 = str2double(data.data5);
data.data6 = str2double(data.data6);
data.data7 = str2double(data.data7);
data.data8 = str2double(data.data8);
data.data9 = str2double(data.data9);
data.data10 =str2double(data.data10);
data.data11 = str2double(data.data11);
data=data(2:end,:);
datas=data{:,:};
dat2=data(:,2);
sz = 1;
a=scatter(data{:,4},data{:,5},sz);
gscatter(data{:,4},data{:,5},data{:,1},'brgyk','ooooo',1);
cycles=unique(data.data1);
for i=1:max(cycles);
    num=cycles(i);
    data1=data(data.data1==num,:);
    figure();
    subplot(3, 2, 1); scatter(data1{:,2},data1{:,3},1); 
    xlabel(strcat('Channel 1')); ylabel('Channel 2');
    pbaspect([1 1 1]); 
    
    subplot(3, 2, 2); scatter(data1{:,2},data1{:,4},1);
    xlabel(strcat('Channel 1')); ylabel('Channel 3'); pbaspect([1 1 1]); 
    
    subplot(3, 2, 3); scatter(data1{:,2},data1{:,5},1);
    xlabel(strcat('Channel 1')); ylabel('Channel 4'); 
    pbaspect([1 1 1]); 
    
    subplot(3, 2, 4); scatter(data1{:,3},data1{:,4},1);
    xlabel(strcat('Channel 2')); ylabel('Channel 3');
    pbaspect([1 1 1]); 
   
    subplot(3, 2, 5); scatter(data1{:,3},data1{:,5},1); 
    xlabel(strcat('Channel 2')); ylabel('Channel 4');
    pbaspect([1 1 1]); 
    
    subplot(3, 2, 6); scatter(data1{:,4},data1{:,5},1); 
    xlabel(strcat('Channel 3')); ylabel('Channel 4');
    pbaspect([1 1 1]);
    savefig(strcat('Crosstalk_cycle',num2str(num),'.fig'));
end 



