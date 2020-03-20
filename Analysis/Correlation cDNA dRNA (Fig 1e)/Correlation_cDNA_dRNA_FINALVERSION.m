%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%CORTEX%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
C1S1=readmatrix('L:\4plex_assay\200313_r1c1\Detected_spots\dRNA_ROI1_tr1.csv');
C1S2=readmatrix('L:\4plex_assay\200313_r1c1\Detected_spots\dRNA_ROI1_tr4.csv');
C1S3=readmatrix('L:\4plex_assay\200313_r1c1\Detected_spots\cDNA_ROI1_tr2.csv');
C1S4=readmatrix('L:\4plex_assay\200313_r1c1\Detected_spots\cDNA_ROI1_tr3.csv');

%GENERATING EMPTY VARIABLES
CLX=[];
lowX=[];
highX=[];
CLY=[];
lowY=[];
highY=[];
CHANNEL=[];

%CHANNEL1
C1S1CH1=C1S1(C1S1(:,4)==1,:);
C1S2CH1=C1S2(C1S2(:,4)==1,:);
C1S3CH1=C1S3(C1S3(:,4)==1,:);
C1S4CH1=C1S4(C1S4(:,4)==1,:);

meX=mean([size(C1S1CH1,1),size(C1S2CH1,1)]);
CLX=[CLX,meX];
sqX=std([size(C1S1CH1,1),size(C1S2CH1,1)]);
lowX=[lowX,sqX];
highX=[highX,meX+sqX];
meY=mean([size(C1S3CH1,1),size(C1S4CH1,1)]);
CLY=[CLY,meY];
sqY=std([size(C1S3CH1,1),size(C1S4CH1,1)]);
lowY=[lowY,sqY];
highY=[highY,meY+sqY];
CHANNEL=[CHANNEL,1];


%CHANNEL2
C1S1CH2=C1S1(C1S1(:,4)==2,:);
C1S2CH2=C1S2(C1S2(:,4)==2,:);
C1S3CH2=C1S3(C1S3(:,4)==2,:);
C1S4CH2=C1S4(C1S4(:,4)==2,:);

meX=mean([size(C1S1CH2,1),size(C1S2CH2,1)]);
CLX=[CLX,meX];
sqX=std([size(C1S1CH2,1),size(C1S2CH2,1)]);
lowX=[lowX,sqX];
highX=[highX,meX+sqX];
meY=mean([size(C1S3CH2,1),size(C1S4CH2,1)]);
CLY=[CLY,meY];
sqY=std([size(C1S3CH2,1),size(C1S4CH2,1)]);
lowY=[lowY,sqY];
highY=[highY,meY+sqY];
CHANNEL=[CHANNEL,2];


%CHANNEL2
C1S1CH3=C1S1(C1S1(:,4)==3,:);
C1S2CH3=C1S2(C1S2(:,4)==3,:);
C1S3CH3=C1S3(C1S3(:,4)==3,:);
C1S4CH3=C1S4(C1S4(:,4)==3,:);

meX=mean([size(C1S1CH3,1),size(C1S2CH3,1)]);
CLX=[CLX,meX];
sqX=std([size(C1S1CH3,1),size(C1S2CH3,1)]);
lowX=[lowX,sqX];
highX=[highX,meX+sqX];
meY=mean([size(C1S3CH3,1),size(C1S4CH3,1)]);
CLY=[CLY,meY];
sqY=std([size(C1S3CH3,1),size(C1S4CH3,1)]);
lowY=[lowY,sqY];
highY=[highY,meY+sqY];
CHANNEL=[CHANNEL,3];


%CHANNEL2
C1S1CH4=C1S1(C1S1(:,4)==4,:);
C1S2CH4=C1S2(C1S2(:,4)==4,:);
C1S3CH4=C1S3(C1S3(:,4)==4,:);
C1S4CH4=C1S4(C1S4(:,4)==4,:);

meX=mean([size(C1S1CH4,1),size(C1S2CH4,1)]);
CLX=[CLX,meX];
sqX=std([size(C1S1CH4,1),size(C1S2CH4,1)]);
lowX=[lowX,sqX];
highX=[highX,meX+sqX];
meY=mean([size(C1S3CH4,1),size(C1S4CH4,1)]);
CLY=[CLY,meY];
sqY=std([size(C1S3CH4,1),size(C1S4CH4,1)]);
lowY=[lowY,sqY];
highY=[highY,meY+sqY];
CHANNEL=[CHANNEL,4];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%CORTEX%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
C1S1=readmatrix('L:\4plex_assay\200313_r1c1\Detected_spots\dRNA_ROI2_tr1.csv');
C1S2=readmatrix('L:\4plex_assay\200313_r1c1\Detected_spots\dRNA_ROI2_tr4.csv');
C1S3=readmatrix('L:\4plex_assay\200313_r1c1\Detected_spots\cDNA_ROI2_tr2.csv');
C1S4=readmatrix('L:\4plex_assay\200313_r1c1\Detected_spots\cDNA_ROI2_tr3.csv');

%CHANNEL1
C1S1CH1=C1S1(C1S1(:,4)==1,:);
C1S2CH1=C1S2(C1S2(:,4)==1,:);
C1S3CH1=C1S3(C1S3(:,4)==1,:);
C1S4CH1=C1S4(C1S4(:,4)==1,:);

meX=mean([size(C1S1CH1,1),size(C1S2CH1,1)]);
CLX=[CLX,meX];
sqX=std([size(C1S1CH1,1),size(C1S2CH1,1)]);
lowX=[lowX,sqX];
highX=[highX,meX+sqX];
meY=mean([size(C1S3CH1,1),size(C1S4CH1,1)]);
CLY=[CLY,meY];
sqY=std([size(C1S3CH1,1),size(C1S4CH1,1)]);
lowY=[lowY,sqY];
highY=[highY,meY+sqY];
CHANNEL=[CHANNEL,1];


%CHANNEL2
C1S1CH2=C1S1(C1S1(:,4)==2,:);
C1S2CH2=C1S2(C1S2(:,4)==2,:);
C1S3CH2=C1S3(C1S3(:,4)==2,:);
C1S4CH2=C1S4(C1S4(:,4)==2,:);

meX=mean([size(C1S1CH2,1),size(C1S2CH2,1)]);
CLX=[CLX,meX];
sqX=std([size(C1S1CH2,1),size(C1S2CH2,1)]);
lowX=[lowX,sqX];
highX=[highX,meX+sqX];
meY=mean([size(C1S3CH2,1),size(C1S4CH2,1)]);
CLY=[CLY,meY];
sqY=std([size(C1S3CH2,1),size(C1S4CH2,1)]);
lowY=[lowY,sqY];
highY=[highY,meY+sqY];
CHANNEL=[CHANNEL,2];


%CHANNEL2
C1S1CH3=C1S1(C1S1(:,4)==3,:);
C1S2CH3=C1S2(C1S2(:,4)==3,:);
C1S3CH3=C1S3(C1S3(:,4)==3,:);
C1S4CH3=C1S4(C1S4(:,4)==3,:);

meX=mean([size(C1S1CH3,1),size(C1S2CH3,1)]);
CLX=[CLX,meX];
sqX=std([size(C1S1CH3,1),size(C1S2CH3,1)]);
lowX=[lowX,sqX];
highX=[highX,meX+sqX];
meY=mean([size(C1S3CH3,1),size(C1S4CH3,1)]);
CLY=[CLY,meY];
sqY=std([size(C1S3CH3,1),size(C1S4CH3,1)]);
lowY=[lowY,sqY];
highY=[highY,meY+sqY];
CHANNEL=[CHANNEL,3];


%CHANNEL2
C1S1CH4=C1S1(C1S1(:,4)==4,:);
C1S2CH4=C1S2(C1S2(:,4)==4,:);
C1S3CH4=C1S3(C1S3(:,4)==4,:);
C1S4CH4=C1S4(C1S4(:,4)==4,:);

meX=mean([size(C1S1CH4,1),size(C1S2CH4,1)]);
CLX=[CLX,meX];
sqX=std([size(C1S1CH4,1),size(C1S2CH4,1)]);
lowX=[lowX,sqX];
highX=[highX,meX+sqX];
meY=mean([size(C1S3CH4,1),size(C1S4CH4,1)]);
CLY=[CLY,meY];
sqY=std([size(C1S3CH4,1),size(C1S4CH4,1)]);
lowY=[lowY,sqY];
highY=[highY,meY+sqY];
CHANNEL=[CHANNEL,4];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%EPENDYMAL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
C1S1=readmatrix('L:\4plex_assay\200313_r1c1\Detected_spots\dRNA_ROI3_tr1.csv');
C1S2=readmatrix('L:\4plex_assay\200313_r1c1\Detected_spots\dRNA_ROI3_tr4.csv');
C1S3=readmatrix('L:\4plex_assay\200313_r1c1\Detected_spots\cDNA_ROI3_tr2.csv');
C1S4=readmatrix('L:\4plex_assay\200313_r1c1\Detected_spots\cDNA_ROI3_tr3.csv');

%GENERATING EMPTY VARIABLES

%CHANNEL1
C1S1CH1=C1S1(C1S1(:,4)==1,:);
C1S2CH1=C1S2(C1S2(:,4)==1,:);
C1S3CH1=C1S3(C1S3(:,4)==1,:);
C1S4CH1=C1S4(C1S4(:,4)==1,:);

meX=mean([size(C1S1CH1,1),size(C1S2CH1,1)]);
CLX=[CLX,meX];
sqX=std([size(C1S1CH1,1),size(C1S2CH1,1)]);
lowX=[lowX,sqX];
highX=[highX,meX+sqX];
meY=mean([size(C1S3CH1,1),size(C1S4CH1,1)]);
CLY=[CLY,meY];
sqY=std([size(C1S3CH1,1),size(C1S4CH1,1)]);
lowY=[lowY,sqY];
highY=[highY,meY+sqY];
CHANNEL=[CHANNEL,1];


%CHANNEL2
C1S1CH2=C1S1(C1S1(:,4)==2,:);
C1S2CH2=C1S2(C1S2(:,4)==2,:);
C1S3CH2=C1S3(C1S3(:,4)==2,:);
C1S4CH2=C1S4(C1S4(:,4)==2,:);

meX=mean([size(C1S1CH2,1),size(C1S2CH2,1)]);
CLX=[CLX,meX];
sqX=std([size(C1S1CH2,1),size(C1S2CH2,1)]);
lowX=[lowX,sqX];
highX=[highX,meX+sqX];
meY=mean([size(C1S3CH2,1),size(C1S4CH2,1)]);
CLY=[CLY,meY];
sqY=std([size(C1S3CH2,1),size(C1S4CH2,1)]);
lowY=[lowY,sqY];
highY=[highY,meY+sqY];
CHANNEL=[CHANNEL,2];


%CHANNEL2
C1S1CH3=C1S1(C1S1(:,4)==3,:);
C1S2CH3=C1S2(C1S2(:,4)==3,:);
C1S3CH3=C1S3(C1S3(:,4)==3,:);
C1S4CH3=C1S4(C1S4(:,4)==3,:);

meX=mean([size(C1S1CH3,1),size(C1S2CH3,1)]);
CLX=[CLX,meX];
sqX=std([size(C1S1CH3,1),size(C1S2CH3,1)]);
lowX=[lowX,sqX];
highX=[highX,meX+sqX];
meY=mean([size(C1S3CH3,1),size(C1S4CH3,1)]);
CLY=[CLY,meY];
sqY=std([size(C1S3CH3,1),size(C1S4CH3,1)]);
lowY=[lowY,sqY];
highY=[highY,meY+sqY];
CHANNEL=[CHANNEL,3];


%CHANNEL2
C1S1CH4=C1S1(C1S1(:,4)==4,:);
C1S2CH4=C1S2(C1S2(:,4)==4,:);
C1S3CH4=C1S3(C1S3(:,4)==4,:);
C1S4CH4=C1S4(C1S4(:,4)==4,:);

meX=mean([size(C1S1CH4,1),size(C1S2CH4,1)]);
CLX=[CLX,meX];
sqX=std([size(C1S1CH4,1),size(C1S2CH4,1)]);
lowX=[lowX,sqX];
highX=[highX,meX+sqX];
meY=mean([size(C1S3CH4,1),size(C1S4CH4,1)]);
CLY=[CLY,meY];
sqY=std([size(C1S3CH4,1),size(C1S4CH4,1)]);
lowY=[lowY,sqY];
highY=[highY,meY+sqY];
CHANNEL=[CHANNEL,4];


















%PLOTING THE RESULT
figure
scatter(CLY', CLX',10,'k','filled');
figure
gscatter(CLY', CLX',num2str(CHANNEL'));

set(gca,'xscale','log')
set(gca,'yscale','log')
hold on
eb(1) = errorbar(CLY',CLX',lowY', 'horizontal', 'LineStyle', 'none');
hold on
eb(2) = errorbar(CLY',CLX',lowX', 'vertical', 'LineStyle', 'none');
set(eb, 'color', 'k', 'LineWidth', 0.5)
hold on
gscatter(CLY', CLX',num2str(CHANNEL'),[],[],[],[],'cDNA counts','dRNA counts');


b1=CLY'\CLX';
Ycalc=b1*[100:40000];
plot([100:40000],Ycalc)


f=fit(CLX',CLY','poly1')
plot(f,CLX',CLY')


CL=[size(C1S1,1),size(C1S3,1)];
CL=[CL;size(C1S2,1),size(C1S3,1)];
CL=[CL;size(C1S1,1),size(C1S4,1)];
CL=[CL;size(C1S2,1),size(C1S4,1)];

CL=[CL;size(C1S1sel1,1),size(C1S3sel1,1)];
CL=[CL;size(C1S2sel1,1),size(C1S3sel1,1)];
CL=[CL;size(C1S1sel1,1),size(C1S4sel1,1)];
CL=[CL;size(C1S2sel1,1),size(C1S4sel1,1)];

CL=[CL;size(C1S1sel2,1),size(C1S3sel2,1)];
CL=[CL;size(C1S2sel2,1),size(C1S3sel2,1)];
CL=[CL;size(C1S1sel2,1),size(C1S4sel2,1)];
CL=[CL;size(C1S2sel2,1),size(C1S4sel2,1)];

CL=[CL;size(C1S1sel3,1),size(C1S3sel3,1)];
CL=[CL;size(C1S2sel3,1),size(C1S3sel3,1)];
CL=[CL;size(C1S1sel3,1),size(C1S4sel3,1)];
CL=[CL;size(C1S2sel3,1),size(C1S4sel3,1)];

CL=[CL;size(C1S1sel4,1),size(C1S3sel4,1)];
CL=[CL;size(C1S2sel4,1),size(C1S3sel4,1)];
CL=[CL;size(C1S1sel4,1),size(C1S4sel4,1)];
CL=[CL;size(C1S2sel4,1),size(C1S4sel4,1)];

CL=[CL;size(C1S1sel5,1),size(C1S3sel5,1)];
CL=[CL;size(C1S2sel5,1),size(C1S3sel5,1)];
CL=[CL;size(C1S1sel5,1),size(C1S4sel5,1)];
CL=[CL;size(C1S2sel5,1),size(C1S4sel5,1)];



CL=[CL;size(H1S1,1),size(H1S3,1)];
CL=[CL;size(H1S2,1),size(H1S3,1)];
CL=[CL;size(H1S1,1),size(H1S4,1)];
CL=[CL;size(H1S2,1),size(H1S4,1)];

CL=[CL;size(E1S1,1),size(E1S3,1)];
CL=[CL;size(E1S2,1),size(E1S3,1)];
CL=[CL;size(E1S1,1),size(E1S4,1)];
CL=[CL;size(E1S2,1),size(E1S4,1)];

%PATH

scatter(CL(:,1),CL(:,2))

