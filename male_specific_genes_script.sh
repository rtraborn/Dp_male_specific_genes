#!/usr/bin/sh
bedtools=/packages/7x/bedtools/2.17.0/bin/bedtools
gffFile=PA42.4.0.gff

echo "Starting job"

echo "Preparing gff file by extracting only genes"

awk '{ if($3 == "gene") { print }}' $gffFile > PA42.4.0_genes.gff

cat TSRsetMerged-Asex_fem.bed TSRsetMerged-pE_fem.bed > test_female_TSRS.bed
$bedtools sort -i test_female_TSRS.bed > female_TSRs_sorted.bed
#$bedtools intersect -s -v -a TSRsetMerged-Males.bed -b test_female_TSRs_sorted.bed > male_specific_TSRs.bed
$bedtools closest -d -D b -s -iu -a TSRsetMerged-Males.bed -b PA42.4.0_genes.gff > male_TSRs_genes_distance.bed
$bedtools closest -d -D b -s -iu -a test_female_TSRs_sorted.bed -b PA42.4.0_genes.gff >  females_TSRs_genes_distance.bed

perl -pe 's/(\sID\=\w+\;)(\w+\=)(\w+)/\t\3/g' male_TSRs_genes_distance.bed > male_TSRs_genes_distance_i.bed
perl -pe 's/(\sID\=\w+\;)(\w+\=)(\w+)/\t\3/g' females_TSRs_genes_distance.bed > females_TSRs_genes_distance_i.bed

awk '{ if($16 <= 1000) { print }}' male_TSRs_genes_distance_i.bed > male_TSRs_genes_distance_ii.bed
awk '{ if($16 <= 1000) { print }}' females_TSRs_genes_distance_i.bed > females_TSRs_genes_distance_ii.bed

echo "Job complete"
