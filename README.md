# LEI_LAB_TK_132

# Check potential restriction enzyme used
```
./scrips/check_potential_restriction_enzyme.sh ./data1/RumpKD_RP1_Biotin_R1_001.fastq.gz 4 1000000
   Top output
   2009 AGAA
   2042 CTAA
   2087 CTCT
   2091 CTTC
   2125 CATT
   2198 CTCC
   2272 CCAA
   2414 AAAC
   2509 ATAA
   2516 CAAT
   2582 ATAT
   2982 ATTT
   3054 CTTT
   3195 AAAT
   3305 CAAA
   3915 AAAA
   7978 GATC

```

## SnakePipes pipeline based on HiC-Explorer 

### Generate indices for snakePipes tools
createIndices --genomeURL file:///data/lorenziha/ELISSA_LEI/TK_132/data1/dmel-all-chromosome-r6.52.fasta  --gtfURL file:///data/lorenziha/ELISSA_LEI/TK_132/data1/dmel-all-r6.52.gtf -o ./reference dmel-all-r6.52 --snakemakeOptions="-p"

### Run HiC
```
conda actiave snakePipes

HiC -i ./data1 -o ./hic_1 -c ./custom_config_files/hic.config.yaml --snakemakeOptions="-n -p" dmel-all-r6.52
```

## Juicer HiC pipeline

# Make restriction site file for custom dme assembly
# script downloaded and adapted from https://github.com/aidenlab/juicer/blob/main/misc/generate_site_positions.py
```
python ./generate_site_positions.py DpnII dme
```

# Make bwa database
```
bwa index ./data1/dmel-all-chromosome-r6.52.fasta
```

# Make chromosome size file
```
seqtk comp ./data1/dmel-all-chromosome-r6.52.fasta|cut -f 1,2 > ./data1/dmel_chrom_sizes.txt
```

# Check fastq read quality to see if it is necessary to remove sequencing adapters
```
swarm -f ./run_fastqc.swarm --module fastqc
```

# Run juicer pipeline
```
module load juicer
juicer.sh -y ./data1/dme_DpnII.txt -z ./data1/dmel-all-chromosome-r6.52.fasta -p ./data1/dmel_chrom_sizes.txt
```


