#!/bin/bash

##############################################
# Long-read validation of genome assembly
#
# Author: Lidong
#
# Description:
# This script performs validation of genome
# assemblies using long-read sequencing data.
#
# Steps:
#   1. Genome collinearity analysis
#   2. Mapping ONT and HiFi reads
#   3. Sequencing depth calculation
#
# Input:
#   WZS.fa                  Reassembled genome
#   GCA_048338725.1.fa      Published genome
#   WZS.ont.fastq.gz        ONT reads
#   WZS.hifi.fastq.gz       PacBio HiFi reads
#
# Output:
#   BAM alignment files
#   Depth statistics
##############################################

THREADS=96

REF1=WZS.fa
REF2=GCA_048338725.1.fa

ONT=WZS.ont.fastq.gz
HIFI=WZS.hifi.fastq.gz

##############################################
# Step 1: Genome collinearity analysis
##############################################

echo "Step1: Genome collinearity analysis"

 /home/lidong/Software/NGenomeSyn-1.41/bin/GetTwoGenomeSyn.pl \
 -InGenomeA ${REF1} \
 -InGenomeB ${REF2} \
 -MappingBin minimap2 \
 -NumThreads 8 \
 -OutPrefix WZS.GCA_048338725.1.result


##############################################
# Step 2: Mapping ONT reads
##############################################

echo "Step2: Mapping ONT reads"

minimap2 -ax map-ont -t ${THREADS} ${REF1} ${ONT} | \
samtools view -bS - | \
samtools sort -@ 32 -o WZS.ont.bam

samtools index WZS.ont.bam


##############################################
# Step 3: Mapping HiFi reads
##############################################

echo "Step3: Mapping HiFi reads"

minimap2 -ax map-hifi -t ${THREADS} ${REF1} ${HIFI} | \
samtools view -bS - | \
samtools sort -@ 32 -o WZS.hifi.bam

samtools index WZS.hifi.bam


##############################################
# Step 4: Mapping reads to published genome
##############################################

echo "Step4: Mapping reads to published genome"

minimap2 -ax map-ont -t ${THREADS} ${REF2} ${ONT} | \
samtools view -bS - | \
samtools sort -@ 32 -o GCA_048338725.1.ont.bam

samtools index GCA_048338725.1.ont.bam


minimap2 -ax map-hifi -t ${THREADS} ${REF2} ${HIFI} | \
samtools view -bS - | \
samtools sort -@ 32 -o GCA_048338725.1.hifi.bam

samtools index GCA_048338725.1.hifi.bam


##############################################
# Step 5: Depth calculation using PanDepth
##############################################

echo "Step5: Calculating sequencing depth"

for i in *.bam
do
    /home/lidong/Software/PanDepth-2.25-Linux-x86_64/pandepth \
    -i ${i} \
    -w 10000 \
    -o ${i}.depth
done

echo "Long-read validation finished"