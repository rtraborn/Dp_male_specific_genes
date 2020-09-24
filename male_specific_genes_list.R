library(dplyr)
setwd("/home/rraborn/Daphnia_CAGE_data_4_0/")

male_genes <- read.table(file="male_TSRs_genes_distance_ii.bed", header=FALSE)
female_genes <- read.table(file="females_TSRs_genes_distance_ii.bed", header=FALSE)

male_genes_uniq <- unique(male_genes[,15])
female_genes_uniq <- unique(female_genes[,15])

non_matching_genes <- setdiff(male_genes_uniq, female_genes_uniq)

male_specific_df <- male_genes[male_genes[,15] %in% non_matching_genes,]

colnames(male_specific_df) <- c("chr1", "start1", "end1", "tsrID", "nTAGs", "strand", "chr2", "annotation", "feature", "start2", "end2", "score1", "strand", "score2", "geneID", "distanceToGene")

write.table(male_specific_df, file="male_specific_genes.bed", col.names = TRUE, quote = FALSE)



