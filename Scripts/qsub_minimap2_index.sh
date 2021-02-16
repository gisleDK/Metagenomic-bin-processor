#!/bin/sh
### Note: No commands may be executed until after the #PBS lines
### Account information
#PBS -W group_list=<your group> -A <your group>
### Job name (comment out the next line to get the name of the script used as the job name)
#PBS -N minimap2_index
### Output files (comment out the next 2 lines to get the job name used instead)
#PBS -e $PBS_JOBID.minimap2_index.stderr
#PBS -o $PBS_JOBID.minimap2_index.stdout
### Only send mail when job is aborted or terminates abnormally
#PBS -m n
### Number of nodes
#PBS -l nodes=1:ppn=38:thinnode
### Memory
#PBS -l mem=180gb
### Requesting time - format is <days>:<hours>:<minutes>:<seconds> (here, 30 days)
#PBS -l walltime=30:00:00:00
# V1.00 Written by Gisle Vestergaard (gislevestergaard@gmail.com)
# Go to the directory from where the job was submitted (initial directory is $HOME)
echo Working directory is "$PBS_O_WORKDIR"
cd "$PBS_O_WORKDIR"
 
### Here follows the user commands:
# This script is used in Step 6 of the binning workflow to index contigs for read-mapping with minimap2.
[ $# != 2 ] && { echo "Usage: qsub -F '<fasta catalogue to index FILE> <Output index FILE>' qsub_minimap2_index.sh"; exit 1; }
export PATH=/home/projects/cu_10108/data/Bin/Programs/miniconda3/bin:$PATH
source activate metagenomics

INPUT=$1
OUTPUT=$(echo "$2" | sed 's/\.mmi$//g')

minimap2 -d "$OUTPUT".mmi "$INPUT"
