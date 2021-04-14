
genemat <- read.table(snakemake@input[["matrix"]], header = T, sep = "\t", row.names=1)
rows <- length(genemat[,1]) #    
cols <- length(genemat[1,])

gene_clusters <- read.table(snakemake@input[["gene_clusters"]], header = F, sep=" ")
clustercounts <- as.data.frame(table(gene_clusters[,2])) #counting the genes of all bins
cluster_order <- unique(gene_clusters[,2])


start <- 1
cluster_names <- array("NA", dim=length(clustercounts$Freq))
count <- 0

for (i in cluster_order){
  count <- count + 1
  size <- clustercounts$Freq[clustercounts$Var1 == i]
  m_name <- paste('Cluster', i, sep = "")
  cluster_names[count] <- m_name 
  end <- start + size - 1
  assign(m_name, as.matrix(genemat[start:end,]))
  # assign(m_name, genemat[start:end,])
  start <- end + 1
}
 
#combining the clusters into a large list
clusterlist <- mget(cluster_names)

saveRDS(clusterlist, file=snakemake@output[["R_clusters"]])

# Saving the gene lengths as a named array of integers
gene_lengths <- read.table(snakemake@input[["gene_lengths"]], header=F, sep="\t")
genes <- split(gene_lengths[,2]*3, gene_lengths[,1]) #multiplying by 3 to go from prot to nucleotide
genes <- unlist(genes)

saveRDS(genes, file=snakemake@output[["R_gene_lengths"]])
