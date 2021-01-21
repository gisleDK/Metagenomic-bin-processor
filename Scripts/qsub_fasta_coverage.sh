#!/bin/sh
### Note: No commands may be executed until after the #PBS lines
### Account information
#PBS -W group_list=<your group> -A <your group>
### Job name (comment out the next line to get the name of the script used as the job name)
#PBS -N fasta_coverage
### Output files (comment out the next 2 lines to get the job name used instead)
#PBS -e $PBS_JOBID.fasta_coverage.stderr
#PBS -o $PBS_JOBID.fasta_coverage.stdout
### Only send mail when job is aborted or terminates abnormally
#PBS -m n
### Number of nodes
#PBS -l nodes=1:ppn=40:thinnode
### Requesting time - format is <days>:<hours>:<minutes>:<seconds> (here, 30 days)
#PBS -l walltime=30:00:00:00
# V1.00 Written by Gisle Vestergaard (gislevestergaard@gmail.com)
# Go to the directory from where the job was submitted (initial directory is $HOME)
cd "$PBS_O_WORKDIR"
 
### Here follows the user commands:
[ $# != 3 ] && { echo "Usage: qsub -F '<Directory containing ONLY the wanted and sorted bam files DIR> <reference contigs fasta FILE> <Depth output STRING>' qsub_contig_coverage.sh"; exit 1; }
INDIR=$1
REF=$2
OUTPUT=$3
SAMPLE=$(echo "$1" | cut -f 1 -d . | rev | cut -f 1 -d / | rev )
BAM=$(ls "$1" | grep '.bam$' | tr '\n' ' ' | sed 's/ $//g' )

jgi_summarize_bam_contig_depths --referenceFasta "$REF" --outputDepth "$OUTPUT".jgi $BAM
