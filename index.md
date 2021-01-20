# Vamb tools
## Introduction
This is a collection of tools that should help with downstream analysis of data obtained from Vamb binning.
Vamb provides not only the binning clusters of all related contigs but also the bins obtained from individual samples and like many other programs allows a lot of options. Be aware that your question should dictate your workflow but I am providing information about how I run Vamb to allow better reproduction of my workflows.
The provided scripts are all made for high-performance computing servers using a TORQUE Resource Manager and more specifically tested/running on [Computerome 2.0](https://www.computerome.dk/display/C2W/Computerome+2.0)
## Binning using Vamb
This example binning workflow was used for fecal samples. Remember to adjust according to your data and hypothesis. You should also check input/output using [FastQC](https://github.com/s-andrews/FastQC) at every step to insure optimal quality. Remember, trash in -> trash out.
### Overview
1. [This script](https://github.com/gisleDK/Vamb_tools/blob/main/Scripts/qsub_bbduk_KTrim.sh) removes adapter sequence from raw reads using [bbduk](https://jgi.doe.gov/data-and-tools/bbtools/bb-tools-user-guide/).
2. [This script](https://github.com/gisleDK/Vamb_tools/blob/main/Scripts/qsub_sickle.sh) performs trimming of low quality sequence using [Sickle](https://github.com/najoshi/sickle).
3. [This script](https://github.com/gisleDK/Vamb_tools/blob/main/Scripts/qsub_bbmap_Decon.sh) removes host contamination [bbmap](https://jgi.doe.gov/data-and-tools/bbtools/bb-tools-user-guide/).
4. [This script](https://github.com/gisleDK/Vamb_tools/blob/main/Scripts/qsub_spades.sh) does assembly using [Spades](https://github.com/ablab/spades).
5. For binning we should set a lower-cutoff limit for contig size. 1500 bp seems a good compromise and is also the default value for Metabat. You can use [this script](https://github.com/gisleDK/Biopythonpieces/blob/master/Scripts/fasta_select_size.py) for selecting contigs based on size.
5. [This script] maps reads using [Minimap2](https://github.com/ablab/spades)
6. Contig coverage using JGIs [jgi_summarize_bam_contig_depths](https://bitbucket.org/berkeleylab/metabat/src/master/), which is actually part of the Metabat binner.


### Detailed steps


