#!/bin/sh
### Note: No commands may be executed until after the #PBS lines
### Account information
#PBS -W group_list=<your group> -A <your group>
### Job name (comment out the next line to get the name of the script used as the job name)
#PBS -N minimap2_align
### Output files (comment out the next 2 lines to get the job name used instead)
#PBS -e $PBS_JOBID.minimap2_align.stderr
#PBS -o $PBS_JOBID.minimap2_align.stdout
### Only send mail when job is aborted or terminates abnormally
#PBS -m n
### Number of nodes
#PBS -l nodes=1:ppn=40:thinnode
### Memory
#PBS -l mem=180gb
### Requesting time - format is <days>:<hours>:<minutes>:<seconds> (here, 30 days)
#PBS -l walltime=30:00:00:00
# V1.00 Written by Gisle Vestergaard (gislevestergaard@gmail.com)
# Go to the directory from where the job was submitted (initial directory is $HOME)
cd "$PBS_O_WORKDIR"
 
### Here follows the user commands:
[ $# != 2 ] && { echo "Usage: qsub -F '<sample DIR> <reference database FILE>' qsub_minimap2_align.sh"; exit 1; }
INPUT=$1
SAMPLE=$(echo "$1" | sed 's/\/$//'g | rev | cut -f 1 -d / | rev )
REF=$(echo "$2" | rev | cut -f 1 -d / | rev | sed 's/\.mmi//g')


minimap2 -v 1 -t 40 -N 50 -ax sr "$REF".mmi "$INPUT"/"$SAMPLE"_1.fastq "$INPUT"/"$SAMPLE"_2.fastq | samtools view -T "$REF".fasta -F 3584 -b --threads 40 | samtools sort --threads 40 > "$SAMPLE".bam
