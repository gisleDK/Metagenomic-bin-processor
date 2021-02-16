#!/bin/sh
### Note: No commands may be executed until after the #PBS lines
### Account information
#PBS -W group_list=<your group> -A <your group>
### Job name (comment out the next line to get the name of the script used as the job name)
#PBS -N spades_assembly
### Output files (comment out the next 2 lines to get the job name used instead)
#PBS -e $PBS_JOBID.spades_assembly.stderr
#PBS -o $PBS_JOBID.spades_assembly.stdout
### Only send mail when job is aborted or terminates abnormally
#PBS -m n
### Number of nodes
#PBS -l nodes=thinnode
### Memory
#PBS -l mem=180gb
### Requesting time - format is <days>:<hours>:<minutes>:<seconds> (here, 2 days)
#PBS -l walltime=02:00:00:00
# V1.00 Written by Gisle Vestergaard (gislevestergaard@gmail.com)
# Go to the directory from where the job was submitted (initial directory is $HOME)
echo Working directory is "$PBS_O_WORKDIR"
cd "$PBS_O_WORKDIR"
# This is where the work is done
# This script is used in Step 4 of the binning workflow which does the sequence assembly.
# You might want to adjust the kmers used depending on your data.
[ $# != 3 ] && { echo "Usage: qsub -F '<R1 FILE> <R2 FILE> <OUTDIR>' qsub_spades_assembly.sh"; exit 1; }
R1=$1
R1_pure=$(echo "$R1" | cut -f 1-4 -d '_')
R2=$2
OUTDIR=$3
mkdir -p "$OUTDIR"/"$R1_pure"
metaspades.py --tmp-dir "$OUTDIR"/"$R1_pure"/metaspades.tmp -t 38 -m 170 -o "$OUTDIR"/"$R1_pure" -1 "$R1" -2 "$R2" -k 21,33,55,77,99,127
