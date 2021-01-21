#!/bin/sh
### Note: No commands may be executed until after the #PBS lines
### Account information
#PBS -W group_list=<your group> -A <your group>
### Job name (comment out the next line to get the name of the script used as the job name)
#PBS -N vamb_binning
### Output files (comment out the next 2 lines to get the job name used instead)
#PBS -e $PBS_JOBID.vamb_binning.stderr
#PBS -o $PBS_JOBID.vamb_binning.stdout
### Only send mail when job is aborted or terminates abnormally
#PBS -m n
### Number of nodes
#PBS -l nodes=1:gpus=1:ppn=40
### Requesting time - format is <days>:<hours>:<minutes>:<seconds> (here, 30 days)
#PBS -l walltime=30:00:00:00
# V1.00 Written by Gisle Vestergaard (gislevestergaard@gmail.com)
# Go to the directory from where the job was submitted (initial directory is $HOME)
cd "$PBS_O_WORKDIR"
 
### Here follows the user commands:
[ $# != 4 ] && { echo "Usage: qsub -F '<JGI contig coverage FILE> <Concatenated contigs fasta FILE> <Output DIR> <Minimum output bin size INTEGER>' qsub_vamb_bin.sh"; exit 1; }
JGI=$1
FASTA=$2
OUTDIR=$3
MINSIZE=$4

vamb -o _ --cuda --jgi "$JGI" --fasta "$FASTA" --outdir "$OUTDIR" --minfasta "$MINSIZE"
