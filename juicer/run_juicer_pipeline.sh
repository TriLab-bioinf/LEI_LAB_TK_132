#!/usr/bin/bash

# Make restriction site file for custom dme assembly
# script downloaded and adapted from https://github.com/aidenlab/juicer/blob/main/misc/generate_site_positions.py  
python ./generate_site_positions.py DpnII dme

# Make bwa database
bwa index ./data1/dmel-all-chromosome-r6.52.fasta

# Make chromosome size file 
seqtk comp ./data1/dmel-all-chromosome-r6.52.fasta|cut -f 1,2 > ./data1/dmel_chrom_sizes.txt

# Check fastq read quality to see if it is necessary to remove sequencing adapters
swarm -f ./run_fastqc.swarm --module fastqc

# Run juicer pipeline
module load juicer
juicer.sh -y ./data1/dme_DpnII.txt -z ./data1/dmel-all-chromosome-r6.52.fasta -p ./data1/dmel_chrom_sizes.txt



