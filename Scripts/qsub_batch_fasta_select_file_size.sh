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
# This script is made to run fasta_select_file_size.py on larger scale. It reads a directory of concatenated fasta files, usually bins and selects according
# to size requirements of each bin. It also creates a visualization of the bin size distribution.
[ $# != 5 ] && { echo "Usage: qsub -F '<input directory containing fasta .fna files DIR> <larger/smaller STRING> <cut-off INT> <output directory DIR> <output list of bin sizes FILE>' qsub_batch_fasta_select_file_size.py"; exit 1; }
FASTA=$1
STRING=$2
INT=$3
OUT=$4
LIST=$5

mkdir -p $OUT

if [[ "$STRING" == "larger" ]]; then
	/home/projects/cu_10108/data/Bin/parallel -j 38 '/home/projects/cu_10108/data/Scripts/biopythonpieces_fasta_select_file_size.py -i {1} -L {2} -o {3}/{1} -l {4}' :::: $FASTA ::: $INT ::: $OUT ::: $LIST
elif [[ "$STRING" == "smaller" ]]; then
	/home/projects/cu_10108/data/Bin/parallel -j 38 '/home/projects/cu_10108/data/Scripts/biopythonpieces_fasta_select_file_size.py -i {1} -S {2} -o {3}/{1} -l {4}' :::: $FASTA ::: $INT ::: $OUT ::: $LIST
else
	echo "$2 is not a valid option"
	echo "Usage: qsub -F '<input directory containing fasta .fna files DIR> <larger/smaller STRING> <cut-off INT> <output directory DIR> <output file name for list of bin sizes FILE>' qsub_batch_fasta_select_file_size.py"; exit 1;
fi

echo "Running R script to visualize ALL bin sizes"
Rscript /home/projects/cu_10108/data/Scripts/biopythonpieces_fasta_select_file_size.r $LIST
