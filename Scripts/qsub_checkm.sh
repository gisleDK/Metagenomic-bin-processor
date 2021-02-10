#!/bin/sh
### Note: No commands may be executed until after the #PBS lines
### Account information
#PBS -W group_list=cu_10108 -A cu_10108
### Job name (comment out the next line to get the name of the script used as the job name)
#PBS -N checkm
### Output files (comment out the next 2 lines to get the job name used instead)
#PBS -e $PBS_JOBID.checkm.stderr
#PBS -o $PBS_JOBID.checkm.stdout
### Only send mail when job is aborted or terminates abnormally
#PBS -m n
### Number of nodes
#PBS -l nodes=1:ppn=40:thinnode
### Requesting time - format is <days>:<hours>:<minutes>:<seconds> (here, 30 days)
#PBS -l walltime=30:00:00:00
# V1.00 Written by Gisle Vestergaard (gislevestergaard@gmail.com)
# Go to the directory from where the job was submitted (initial directory is $HOME)
cd "$PBS_O_WORKDIR"
 
# This is where the work is done
# This script is used in Step 4 of the binning workflow which does the sequence assembly.
# You might want to adjust the kmers used depending on your data.

[ $# != 2 ] && { echo "Usage: qsub -F '<Directory containing bins DIR> <Output directory DIR> ' qsub_checkm.sh"; exit 1; }
export PATH=/home/projects/cu_10108/data/Bin/Programs/miniconda3/bin:$PATH
source activate vamb
INDIR=$1
OUTDIR=$2

checkm lineage_wf "$INDIR" "$OUTDIR" -t 5 --pplacer_threads 5
checkm qa "$OUTDIR"/lineage.ms "$OUTDIR" -o 2 -t 38 -f "OUTDIR"/"$INDIR"_checkm_qa.tsv
