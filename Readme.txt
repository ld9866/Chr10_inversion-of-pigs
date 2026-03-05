Pipeline Overview

This repository contains a set of scripts used for genome assembly, Hi-C scaffolding, structural validation, and manual inspection of potential assembly errors. The workflow integrates PacBio HiFi reads, Nanopore ultra-long reads, and Hi-C data to generate and validate a chromosome-level genome assembly.

The pipeline consists of four main steps:

Script Descriptions
01.genome_assembly.sh

This script performs de novo genome assembly using hifiasm, integrating PacBio HiFi reads, Nanopore ultra-long reads, and Hi-C data. The assembly is generated with haplotype-aware phasing, producing high-quality contigs that serve as the foundation for downstream scaffolding and validation analyses.

02.hic_analysis.sh

This script performs Hi-C based scaffolding and contact matrix generation using the Juicer pipeline. It includes genome indexing, restriction site generation, and Hi-C alignment processing to produce .hic interaction matrices that can be visualized in Juicebox or IGV for evaluating chromosome-scale assembly accuracy.

03.long_read_validation.sh

This script validates the genome assembly by mapping Nanopore ultra-long reads and PacBio HiFi reads to both the newly assembled genome and the published reference genome. Structural consistency and read depth are assessed using minimap2, samtools, and PanDepth, which helps detect potential assembly errors such as inversions or misjoins.

04.IGV_visualization.sh

This script launches IGV (Integrative Genomics Viewer) and loads the reference genome together with the aligned BAM files for manual inspection of structural variation and assembly breakpoints. It is particularly useful for visually confirming structural signals such as inversions or coverage anomalies in candidate genomic regions.