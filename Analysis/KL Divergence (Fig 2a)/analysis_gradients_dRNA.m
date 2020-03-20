%This script is the first part in gradient analysis for circular tissues
%(from outside to inside)

%This specify both the basis image and the details of the gene
I=imread('O:\dRNA project\20x ROI for KDE C1\TestMipping_cortex_b1_s3_c_4.tif');
decoded_file='O:\dRNA project\20x ROI for KDE C1\TestMipping_cortex_b1_s3_c_.csv';
scale=1;
roi_number=1;
limit=6000;
bandwidth=200;

table=readtable(decoded_file);
[Coord, Coord_write, blank] = drawpolygon(I, roi_number, scale);


%DENSITY OUT
dist=[];
size(table,1)
for qul =1:size(table,1)
disp(qul);
sele=table(qul,:);
MAT=sqrt(min((Coord_write(:,2)-table2array(sele(:,2))).^2+(Coord_write(:,3)-table2array(sele(:,3))).^2));
dist=[dist,MAT];  
end

distance=table(:,2:4);
distance.Gene=table(:,4);
distance.Density=dist';
cat=unique(distance.Gene);

figure(1221)
TAC=[];
DIS=[];
NAM=[];
DIVEC=[];
SUMTOT=[];
for gens=1:size(cat);
gen=cat.Var4(gens);
tab.Gene= gen;
SUMTOT=[SUMTOT,sum(ismember(table2array(distance.Gene),tab.Gene))];
distsel=distance(ismember(table2array(distance.Gene),tab.Gene),:);
as=fitdist(distsel.Density,'kernel','BandWidth',bandwidth);
set=pdf(as,1:1:limit);
si=plot(1:1:limit,set);
DIVEC=[DIVEC;set];
DIS=[DIS,si];
si;
hold on
end
legend(DIS,table2array(cat));


%drna

%This specify both the basis image and the details of the gene
I=imread('O:\dRNA project\20x ROI for KDE C1\TestMipping_cortex_b1_s4_c_4.tif');
decoded_file='O:\dRNA project\20x ROI for KDE C1\TestMipping_cortex_b1_s4_c_.csv';
scale=1;
roi_number=1;
limit=6000;
bandwidth=200;

table=readtable(decoded_file);
[Coord, Coord_write, blank] = drawpolygon(I, roi_number, scale);


%DENSITY OUT
dist=[];
size(table,1)
for qul =1:size(table,1)
disp(qul);
sele=table(qul,:);
MAT=sqrt(min((Coord_write(:,2)-table2array(sele(:,2))).^2+(Coord_write(:,3)-table2array(sele(:,3))).^2));
dist=[dist,MAT];  
end

%%%%%%%%%%%THIS IS FOR RANDOM GENERATOR%%%%%%%%%%%%
dist=randsample(1:8000,size(dist,2),true);
%%%%%%%%%%%THIS IS FOR RANDOM GENERATOR%%%%%%%%%%%%

distance2=table(:,2:4);
distance2.Gene=table(:,4);
distance2.Density=dist';
cat1=unique(distance2.Gene);

figure(1221)
TAC=[];
DIS=[];
NAM=[];
DIVEC1=[];
SUMTOT1=[];
for gens=1:size(cat1);
gen1=cat1.Var4(gens);
tab1.Gene= gen1;
SUMTOT1=[SUMTOT1,sum(ismember(table2array(distance2.Gene),tab1.Gene))];
distsel=distance2(ismember(table2array(distance2.Gene),tab1.Gene),:);
as=fitdist(distsel.Density,'kernel','BandWidth',bandwidth);
set1=pdf(as,1:1:limit);
si=plot(1:1:limit,set1);
DIVEC1=[DIVEC1;set1];
DIS=[DIS,si];
si;
hold on
end
legend(DIS,table2array(cat));



%DIVEC -DRNA
%DIVEC1 - CDNA

%Calculating Kldivergence
kldivTOT=[];
NAME=[];
ratio=[];
for ngene=1:size(DIVEC,1)
    for ngene2=1:size(DIVEC1,1)
    kldiv1=kldiv(1:1:limit,DIVEC(ngene,:)/(sum(DIVEC(ngene,:))),DIVEC1(ngene2,:)/sum(DIVEC1(ngene2,:)));
    kldivTOT=[kldivTOT,kldiv1];
    ratio=[ratio,SUMTOT(ngene)/SUMTOT1(ngene2)];
    NAME=[NAME;strcat(num2str(ngene),num2str(ngene2))];
    end
end

%ratio=SUMTOT1./SUMTOT;

figure
gscatter(kldivTOT',ratio',cellstr(NAME));

DvsD=[kldivTOT',ratio'];
NameDD=strcat(cellstr(NAME),'DD');

RvsR=[kldivTOT',ratio'];
NameR=strcat(cellstr(NAME),'RR');

DvsR=[kldivTOT',ratio'];
NameD=strcat(cellstr(NAME),'RD');

DvsRandom=[kldivTOT',ratio'];
NameRandom=strcat(cellstr(NAME),'Random');




divCOMB=[DvsR(:,1);RvsR(:,1);DvsD(:,1)]%;DvsRandom(:,1)]

ratioCOMB=[DvsR(:,2);RvsR(:,2);DvsD(:,2)]%;DvsRandom(:,2)]

nameCOMB=[NameD;NameR;NameDD]%;NameRandom];

figure
gscatter(divCOMB',ratioCOMB',nameCOMB);
set(gca, 'YScale', 'linear')

xlabel('KL Divergence') 
ylabel('RCPs in dRNA/RCPs in cDNA') 

