library(pathview)
genes = read.table("myGenes.csv", sep=";", header=TRUE, stringsAsFactors = FALSE)
rownames(genes) = genes[,2]
pathwayID = "hsa04012"
geneIDTYPE = "SYMBOL"
pathview(genes[,2], pathway.id = pathwayID, gene.idtype = geneIDTYPE,plot.col.key= FALSE)
