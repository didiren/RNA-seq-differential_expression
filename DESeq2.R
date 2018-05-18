require("DESeq2")
require("pasilla")
require("ggplot2")
require("gplots")
require("RColorBrewer")
require("pathview")
require("gage")

#Taking the HTseq output text files 
sampleFiles <- grep(".txt",list.files(path = "."),value=TRUE) 
sampleCondition <-sub("(.*treated).*","\\1",sampleFiles)
sampleName <- sub("(.*treated.*)\\.txt","\\1",sampleFiles)
#Building the conditions for treated and untreated
sampleTable <- data.frame(sampleName = sampleName, fileName = sampleFiles, 
                          condition = sampleCondition)

ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable, design= ~ condition) 

# Make "untreated" the baseline level
ddsHTSeq$condition <- relevel(ddsHTSeq$condition, "untreated")
#Run DESeq2
dds <- DESeq(ddsHTSeq)
res <- results(dds)

resOrdered <- res[order(res$padj),]
head(resOrdered)
summary(res)


#significant data set
significant <- resOrdered[is.na(resOrdered$padj)==FALSE,]
significant <- significant[complete.cases(significant),]
significant <- significant[significant$padj< .01,]
upregulate <-significant[significant$log2FoldChange > 1,]
downregulate <-significant[significant$log2FoldChange < -1,]
#Output tables just based on the p-value (BH adjusted)
write.csv(as.data.frame(resOrdered), file="condition_treated_results_2.csv")
write.csv(as.data.frame(significant), file="all_significant_results_2.csv")
write.csv(as.data.frame(upregulate), file="up_regulate_results_2.csv")
write.csv(as.data.frame(downregulate), file="down_regulate_results_2.csv")

#create analysis plots
#MA plot overviewed the two group comparison
plotCounts(dds, gene=which.min(res$padj), intgroup="condition")
plotDispEsts( dds, ylim = c(1e-6, 1e1) )
hist( res$pvalue, breaks=20, col="grey" )
#the normalized results from DESeq2
counts<-counts(dds,normalized=TRUE)
write.csv(as.data.frame(counts),file='normalized_results.csv')


#build the rlog-transfomred data 
rld <- rlog(dds)
head( assay(rld) )
par( mfrow = c( 1, 2 ) )
plot( log2( 1+counts(dds, normalized=TRUE)[, 1:2] ), col="#00000020", pch=20, cex=0.3 )
plot( assay(rld)[, 1:2], col="#00000020", pch=20, cex=0.3 )
plotPCA(rld, intgroup=c("condition"))

sampleDists <- dist( t( assay(rld) ) )
sampleDistMatrix <- as.matrix( sampleDists )
#In order to generate the plot based on your expereiment design, you need to change the sampleName to other vector.
rownames(sampleDistMatrix) <- sampleName
colnames(sampleDistMatrix) <- sampleName
colours = colorRampPalette( rev(brewer.pal(9, "Blues")) )(255)
heatmap.2(margins=c(10,10),sampleDistMatrix, trace="none", col=colours)

library( "genefilter" )
topVarGenes <- head( order( rowVars( assay(rld) ), decreasing=TRUE ), 25 )
heatmap.2(margins=c(10,10), assay(rld)[ topVarGenes, ], scale="row",
          trace="none", dendrogram="column",
          col = colorRampPalette( rev(brewer.pal(9, "RdBu")) )(255))

