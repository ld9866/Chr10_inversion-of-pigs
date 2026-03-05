#!/bin/bash

##############################################
# Hi-C scaffolding pipeline using Juicer
#
# Author: Lidong
# Description:
# This script performs Hi-C based genome
# scaffolding preparation using Juicer.
#
# Input:
#   WZS.fa                genome assembly
#   Hi-C reads (fastq)
#
# Output:
#   .hic interaction file
#   alignment results
##############################################

# -----------------------------
# Software path
# -----------------------------
JUICER=/home/lidong/Software/juicer-1.6
THREADS=128

# -----------------------------
# Input genome
# -----------------------------
GENOME=WZS.fa
GENOME_NAME=WZS

# -----------------------------
# Step 1: BWA index
# -----------------------------
echo "Step 1: Building BWA index..."

bwa index ${GENOME}

# -----------------------------
# Step 2: Generate restriction sites
# -----------------------------
echo "Step 2: Generating restriction sites..."

python ${JUICER}/misc/generate_site_positions.py \
MboI \
${GENOME_NAME} \
${GENOME}

# -----------------------------
# Step 3: Generate chrom.sizes
# -----------------------------
echo "Step 3: Generating chromosome sizes..."

awk 'BEGIN{OFS="\t"}{print $1,$NF}' \
${GENOME_NAME}_MboI.txt \
> ${GENOME_NAME}.chrom.sizes

# -----------------------------
# Step 4: Run Juicer
# -----------------------------
echo "Step 4: Running Juicer..."

${JUICER}/CPU/juicer.sh \
-g ${GENOME_NAME} \
-s MboI \
-D ${JUICER} \
-z ${GENOME} \
-y ${GENOME_NAME}_MboI.txt \
-p ${GENOME_NAME}.chrom.sizes \
-t ${THREADS} \
&> juicer.log

echo "Hi-C processing finished."
