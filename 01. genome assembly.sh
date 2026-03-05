#!/bin/bash

##############################################
# Genome Assembly Pipeline using hifiasm
#
# Author: Lidong
# Description:
# This script performs de novo genome assembly
# using PacBio HiFi reads with Hi-C and Nanopore
# ultra-long reads using hifiasm.
#
# Requirements:
#   hifiasm >= 0.25.0
#
# Input data:
#   1. PacBio HiFi reads
#   2. Hi-C paired-end reads
#   3. Nanopore ultra-long reads
#
# Output:
#   Assembled contigs and assembly graphs
##############################################

# -----------------------------
# Software path
# -----------------------------
HIFIASM=/home/lidong/Software/hifiasm-0.25.0/hifiasm

# -----------------------------
# Input files
# -----------------------------
HIFI=WZS.hifi.fq.gz
HIC_R1=WZS.hic_1.clean.fq.gz
HIC_R2=WZS.hic_2.clean.fq.gz
ONT=WZS.ont.fastq.gz

# -----------------------------
# Output prefix
# -----------------------------
PREFIX=WZS.hifi.hic.ont

# -----------------------------
# Thread number
# -----------------------------
THREADS=256

# -----------------------------
# Run hifiasm assembly
# -----------------------------
$HIFIASM \
-o ${PREFIX} \
-t ${THREADS} \
--h1 ${HIC_R1} \
--h2 ${HIC_R2} \
--ul ${ONT} \
${HIFI} \
2> ${PREFIX}.log

echo "Assembly finished."