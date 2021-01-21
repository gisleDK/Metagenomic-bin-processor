#!/bin/sh
### Note: No commands may be executed until after the #PBS lines
### Account information
#PBS -W group_list=<your group> -A <your group>
### Job name (comment out the next line to get the name of the script used as the job name)
#PBS -N sickle
### Output files (comment out the next 2 lines to get the job name used instead)
#PBS -e $PBS_JOBID.sickle.stderr
#PBS -o $PBS_JOBID.sickle.stdout
### Only send mail when job is aborted or terminates abnormally
#PBS -m n
### Number of nodes
#PBS -l nodes=1:ppn=38:thinnode
### Memory
#PBS -l mem=180gb
### Requesting time - format is <days>:<hours>:<minutes>:<seconds> (here, 1 hour)
#PBS -l walltime=01:00:00
# V1.00 Written by Gisle Vestergaard (gislevestergaard@gmail.com)
# Go to the directory from where the job was submitted (initial directory is $HOME)
echo Working directory is "$PBS_O_WORKDIR"
cd "$PBS_O_WORKDIR"
# This is where the work is done
# This script is used in Step 2 of the binning workflow which trims low quality sequence.
[ $# != 3 ] && { echo "Usage: qsub -F '<R1 FILE> <R2 FILE> <OUTPUT DIR>' qsub_sickle"; exit 1; }

R1=$1
R1_pure=$(echo "$R1" | rev | cut -f1 -d'/' | rev)
R2=$2
R2_pure=$(echo "$R2" | rev | cut -f1 -d'/' | rev)
OUTDIR=$3
mkdir -p "$OUTDIR"
sickle pe -g --qual-type sanger -f "$R1" -r "$R2" -o "$OUTDIR"/"$R1_pure" -p "$OUTDIR"/"$R2_pure" -s "$OUTDIR"/"$R1_pure.singles" -l 100
