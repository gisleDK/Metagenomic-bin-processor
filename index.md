# Vamb tools
## Introduction
This is a collection of tools that should help with downstream analysis of data obtained from Vamb binning.
Vamb provides not only the binning clusters of all related contigs but also the bins obtained from individual samples and like many other programs allows a lot of options. Be aware that your question should dictate your workflow but I am providing information about how I run Vamb to allow better reproduction of my workflows.
The provided scripts are all made for high-performance computing servers using a TORQUE Resource Manager and more specifically tested/running on [Computerome 2.0](https://www.computerome.dk/display/C2W/Computerome+2.0)
## Binning using Vamb
This is the binning workflow used for fecal samples:
1. Adapter removal using [bbduk](https://jgi.doe.gov/data-and-tools/bbtools/bb-tools-user-guide/) using [this script](https://github.com/gisleDK/Vamb_tools/blob/main/Scripts/qsub_bbduk_KTrim.sh).
2. Low quality sequence trimming using [Sickle](https://github.com/najoshi/sickle)
3. Removing host contamination [bbmap](https://jgi.doe.gov/data-and-tools/bbtools/bb-tools-user-guide/)
4. Assembly using [Spades](https://github.com/ablab/spades)
5. Read mapping using [Minimap2](https://github.com/ablab/spades)
6. Contig coverage using JGIs [jgi_summarize_bam_contig_depths](https://bitbucket.org/berkeleylab/metabat/src/master/), which is actually part of the Metabat binner.


