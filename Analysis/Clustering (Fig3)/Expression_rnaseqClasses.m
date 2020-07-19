GENES=readcell('O:\dRNA project\scRNAseqCortex\GENELIST.csv');
MEAN=readcell('O:\dRNA project\scRNAseqCortex\scRNAseqCortex.csv');
me=MEAN(:,1);
me{1,1}='EMPTY';


SELECT=MEAN(ismember(me,GENES),:);
ALL=SELECT;
ALLTAB=cell2table(ALL);
NAMES=MEAN(1,:);
NAMES{1,1}='CLASS';
ALLTAB.Properties.VariableNames=NAMES;
ALLTAB.Properties.RowNames=ALLTAB{:,1}
ALLTAB=ALLTAB(:,2:end);
ALLTAB = sortrows( ALLTAB ,'RowNames');

clustergram(table2array(ALLTAB),'Standardize','Row')

heatmap(ALLTAB),'GridVisible','off','Colormap',parula);


