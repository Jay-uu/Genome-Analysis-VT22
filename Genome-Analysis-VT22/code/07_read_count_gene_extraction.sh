#!/bin/bash -l

#there are different directories for each bin named for example D1_1 for bin 1 from site D1. Inside is the gff file
export annotated_bins=$HOME/genome_analysis_project/Genome-Analysis-VT22/analyses/04_annotation
export D1_counts=/home/jay/genome_analysis_project/Genome-Analysis-VT22/analyses/07_htseq/D1
export D3_counts=/home/jay/genome_analysis_project/Genome-Analysis-VT22/analyses/07_htseq/D3

#go to where I want the output
cd /home/jay/genome_analysis_project/Genome-Analysis-VT22/analyses/07_htseq/
#mkdir top_five_counts
cd top_five_counts

#start with D1
for bin in {1..16}
do
#get the five most expressed genes and read count and print to file
grep -v "__" $D1_counts/bin_${bin}.count | sort -k 2 -n -r | head -5 | sort -k 1 > D1_${bin}_counts.txt
#print locus_tag, ftype, length_bp, gene, EC_number, COG and product of the 5 most expressed genes to a file sorted according to locus_tag
grep -v "__" $D1_counts/bin_${bin}.count | sort -k 2 -n -r | head -5 | awk '{print $1}' | grep -f - $annotated_bins/D1_${bin}/bin_${bin}_*.tsv > D1_${bin}_product.txt
# combine the two files into one using the locus tag as a key and add a header
#note that not all genes have a EC_number and COG
join D1_${bin}_product.txt D1_${bin}_counts.txt | sed -e '1i\locus_tag ftype length_bp gene EC_number COG product read_count' > D1_${bin}_top_reads.txt
# remove the files from the inbetween steps
rm D1_${bin}_counts.txt
rm D1_${bin}_product.txt
done

#then do D3
for bin in {1..30}
do
#get the five most expressed genes and read count and print to file
grep -v "__" $D3_counts/bin_${bin}.count | sort -k 2 -n -r | head -5 | sort -k 1 > D3_${bin}_counts.txt
#print locus_tag, ftype, length_bp, gene, EC_number, COG and product of the 5 most expressed genes to a file sorted according to locus_tag
grep -v "__" $D3_counts/bin_${bin}.count | sort -k 2 -n -r | head -5 | awk '{print $1}' | grep -f - $annotated_bins/D3_${bin}/bin_${bin}_*.tsv > D3_${bin}_product.txt
# combine the two files into one using the locus tag as a key and add a header
#note that not all genes have a EC_number and COG
join D3_${bin}_product.txt D3_${bin}_counts.txt | sed -e '1i\locus_tag ftype length_bp gene EC_number COG product read_count' > D3_${bin}_top_reads.txt
# remove the files from the inbetween steps
rm D3_${bin}_counts.txt
rm D3_${bin}_product.txt
done
