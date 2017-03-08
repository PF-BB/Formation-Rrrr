#lire fichier d'expression et le stocker dans un objet
expr = read.table("expressionMatrix.txt", sep="\t", header=TRUE, row.names=1)

# lire fichier d'annotations des individus et le stocker dans un objet
annot = read.table("annotMatrix.txt", sep="\t", header=TRUE)

# extraire les valeurs d'expression d'un gène d'intérêt
gene="g1"
exprGene = expr[gene, ]

#créer une table expoitable par mon Rmarkdown
out = data.frame(expression=t(exprGene), group=annot$Group)

#ecrire la table de sortie
write.table(out, file="gene1.txt", sep="\t", quote=FALSE, row.names=FALSE)
