#!/bin/sh
### Note: No commands may be executed until after the #PBS lines
### Account information
#PBS -W group_list=<your group> -A <your group>
### Job name (comment out the next line to get the name of the script used as the job name)
#PBS -N decon
### Output files (comment out the next 2 lines to get the job name used instead)
#PBS -e $PBS_JOBID.bbmap_Decon.stderr
#PBS -o $PBS_JOBID.bbmap_Decon.stdout
### Only send mail when job is aborted or terminates abnormally
#PBS -m n
### Number of nodes
#PBS -l nodes=1:ppn=38:thinnode
### Memory
#PBS -l mem=180gb
### Requesting time - format is <days>:<hours>:<minutes>:<seconds> (here, 1 hour)
#PBS -l walltime=99:00:00
# V1.00 Written by Gisle Vestergaard (gislevestergaard@gmail.com)
# Go to the directory from where the job was submitted (initial directory is $HOME)
echo Working directory is "$PBS_O_WORKDIR"
cd "$PBS_O_WORKDIR"
# This is where the work is done
# This script is used in Step 3 of the binning workflow which removes host contamination.
# Remember to specify your reference sequence (See https://jgi.doe.gov/data-and-tools/bbtools/bb-tools-user-guide/bbmap-guide/).
[ $# != 3 ] && { echo "Usage: qsub -F '<R1 FULL PATH> <R2 FULL PATH> <OUTPUT DIR>' qsub_bbmap_DeconHomo.sh"; exit 1; }
export PATH=/home/projects/<Your group>/data/Bin/Programs/miniconda3/bin:$PATH
R1=$1
R2=$2
OUTDIR=$3
mkdir -p "$OUTDIR"
bbmap.sh qin=33 threads=38 in="$R1" in2="$R2" outu1="$OUTDIR"/"$R1" outu2="$OUTDIR"/"$R2" outm1="$OUTDIR"/"$R1".human.fq.gz outm2="$OUTDIR"/"$R2".human.fq.gz path=/home/projects/<Your group>/data/Bin/Programs/bbmap/resources/
