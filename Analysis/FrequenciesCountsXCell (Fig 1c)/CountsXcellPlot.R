#THIS SCRIPT USES THE SEGMENTATION DONE AFTER FINDING BLOBS IN ORDER TO GENERATE THE LINE PLOTS IN FIG 1C)

dRNA=read.csv('L:/4plex_assay/200313_r1c1/dRNA_tr01/Preprocess/Stitched2DTiles_MIST_Ref1/200311_dRNA_01_rd1cy1001_stitched-_ASSIGN_READ_CELL.csv',h=F)
cDNA=read.csv('L:/4plex_assay/200313_r1c1/200313_cDNA_01__tr2_rd1cy1001/Preprocess/Stitched2DTiles_MIST_Ref1/200313_cDNA_01__tr2_rd1cy1001_stitched-_ASSIGN_READ_CELL.csv',h=F)

dRNA$group='dRNA'
cDNA$group='cDNA'

ALL=rbind(cDNA,dRNA)

library(ggplot2)

ggplot(ALL,aes(V4,group=group,fill = group, colour = group)) + geom_line(stat='count',alpha=0.6)+ geom_area(stat='count',aes(fill = group, group = group),alpha = 0.3, position = 'identity')+xlim(0,30)+
  scale_x_continuous(trans='sqrt',breaks = round(seq(min(ALL$V4), max(ALL$V4), by = 4),1))+theme_classic()+ggtitle('Channel0')+labs(x='Signals/cell',y='Number of cells')+
  geom_vline(data=ALL, aes(xintercept=mean(cDNA$V4)), color="#CC6666",linetype="dashed")+
  geom_vline(data=ALL, aes(xintercept=mean(dRNA$V4)), color="#9999CC",linetype="dashed")+
  scale_colour_manual(values=c("#CC6666", "#9999CC"))


ggplot(ALL,aes(V5,group=group,fill = group, colour = group)) + geom_line(stat='count',alpha=0.6)+ geom_area(stat='count',aes(fill = group, group = group),alpha = 0.3, position = 'identity')+
  scale_x_continuous(trans='sqrt',limits=c(0,100),breaks = round(seq(min(ALL$V5), max(ALL$V5), by = 8),1))+theme_classic()+ggtitle('Channel1')+labs(x='Signals/cell',y='Number of cells')+
geom_vline(data=ALL, aes(xintercept=mean(cDNA$V5)), color="#CC6666",linetype="dashed")+
  geom_vline(data=ALL, aes(xintercept=mean(dRNA$V5)), color="#9999CC",linetype="dashed")+
  scale_colour_manual(values=c("#CC6666", "#9999CC"))


ggplot(ALL,aes(V6,group=group,fill = group, colour = group)) + geom_line(stat='count',alpha=0.6)+ geom_area(stat='count',aes(fill = group, group = group),alpha = 0.3, position = 'identity')+xlim(0,30)+
  scale_x_continuous(trans='sqrt',limits=c(0,100),breaks = round(seq(min(ALL$V6), max(ALL$V6), by = 8),1))+theme_classic()+ggtitle('Channel2')+labs(x='Signals/cell',y='Number of cells')+
  geom_vline(data=ALL, aes(xintercept=mean(cDNA$V6)), color="#CC6666",linetype="dashed")+
  geom_vline(data=ALL, aes(xintercept=mean(dRNA$V6)), color="#9999CC",linetype="dashed")+
  scale_colour_manual(values=c("#CC6666", "#9999CC"))


ggplot(ALL,aes(V7,group=group,fill = group, colour = group)) + geom_line(stat='count',alpha=0.6)+ geom_area(stat='count',aes(fill = group, group = group),alpha = 0.3, position = 'identity')+xlim(0,30)+
  scale_x_continuous(trans='sqrt',breaks = round(seq(min(ALL$V7), max(ALL$V7), by = 4),1))+theme_classic()+ggtitle('Channel3')+labs(x='Signals/cell',y='Number of cells')+
  geom_vline(data=ALL, aes(xintercept=mean(cDNA$V7)), color="#CC6666",linetype="dashed")+
  geom_vline(data=ALL, aes(xintercept=mean(dRNA$V7)), color="#9999CC",linetype="dashed")+
  scale_colour_manual(values=c("#CC6666", "#9999CC"))

