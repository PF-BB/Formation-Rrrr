library(pathview)
genes = read.table("genes.txt", sep="\t", header=FALSE)

#il faut que les noms de lignes correspondent aux noms des genes pour que la fonction pathview() fonctionne.
rownames(genes) = as.vector(genes[,1])
pathwayID = "hsa04110"
geneIDTYPE = "SYMBOL"

# pathview prend en entrée un vecteur ou une matrice gene.data
pathview(gene.data=genes, pathway.id = pathwayID, gene.idtype = geneIDTYPE,plot.col.key= FALSE)
