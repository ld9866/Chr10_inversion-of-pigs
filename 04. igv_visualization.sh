#!/bin/bash

##############################################
# IGV Visualization for Assembly Validation
#
# Author: Lidong
#
# Description:
# This script launches IGV and loads the genome
# assembly together with BAM files for manual
# inspection of assembly errors (e.g., inversions).
#
# Input:
#   WZS.fa                  Reassembled genome
#   *.bam                   Alignment files
#
# Recommended inspection region:
#   chr10:28000000-38000000
##############################################

IGV=/home/lidong/Software/IGV_2.17.4/igv.sh

GENOME=WZS.fa

echo "Launching IGV..."

${IGV} \
-g ${GENOME} \
WZS.ont.bam \
WZS.hifi.bam
