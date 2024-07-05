#!/usr/bin/bash
#SBATCH --cpus-per-task=8 --mem=32g --gres=lscratch:100 --partition=quick

module load hicexplorer/3.7.2

MATRIX_FILE=$1
PARAMS=$2
OUT_PREFIX=$(basename $1)

hicPlotMatrix --matrix ${MATRIX_FILE} \
    --clearMaskedBins \
    --outFileName ${OUT_PREFIX}.png \
    --region 2R:17000000-22000000 

# --chromosomeOrder 2L 2R 3L 3R X \

