#!/bin/sh
### Note: No commands may be executed until after the #PBS lines
### Account information
#PBS -W group_list=cu_10108 -A cu_10108
### Job name (comment out the next line to get the name of the script used as the job name)
#PBS -N fasta_select
### Output files (comment out the next 2 lines to get the job name used instead)
#PBS -e $PBS_JOBID.fasta_select.stderr
#PBS -o $PBS_JOBID.fasta_select.stdout
### Only send mail when job is aborted or terminates abnormally
#PBS -m n
### Number of nodes
#PBS -l nodes=1:ppn=38:thinnode
### Requesting time - format is <days>:<hours>:<minutes>:<seconds> (here, 24 hours)
#PBS -l walltime=00:24:00:00
# V1.00 Written by Gisle Vestergaard (gislevestergaard@gmail.com)
# Go to the directory from where the job was submitted (initial directory is $HOME)
echo Working directory is "$PBS_O_WORKDIR"
cd "$PBS_O_WORKDIR"
 
### Here follows the user commands:
# This script is used in Step 5 of the binning workflow to remove small contigs.
# This script is made to run fasta_select.sh on larger scale. It reads a list of concatenated fasta files and selects according
# to size requirements of each individual entry.
[ $# != 4 ] && { echo "Usage: qsub -F '<list of fasta file FILE> <larger/smaller STRING> <cut-off INT> <output directory DIR>' qsub_batch_fasta_select.py"; exit 1; }
FASTA=$1
STRING=$2
INT=$3
OUT=$4

mkdir -p $OUT

if [[ "$STRING" == "larger" ]]; then
	parallel -j 38 '/home/projects/cu_10108/data/Scripts/biopythonpieces_fasta_select.py -f {1} -L {2} -o {3}/{1}' :::: $FASTA ::: $INT ::: $OUT
elif [[ "$STRING" == "smaller" ]]; then
	parallel -j 38 '/home/projects/cu_10108/data/Scripts/biopythonpieces_fasta_select.py -f {1} -S {2} -o {3}/{1}' :::: $FASTA ::: $INT ::: $OUT
else
	echo "$2 is not a valid option"
	echo "Usage: qsub -F '<list of fasta file FILE> <larger/smaller STRING> <Cut-off INT>' qsub_batch_fasta_select.sh"; exit 1;
fi
