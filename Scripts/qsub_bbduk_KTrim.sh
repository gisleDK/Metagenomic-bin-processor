#!/bin/sh
### Note: No commands may be executed until after the #PBS lines
### Account information
#PBS -W group_list=<Your group> -A <Your group>
### Job name (comment out the next line to get the name of the script used as the job name)
#PBS -N bbduk
### Output files (comment out the next 2 lines to get the job name used instead)
#PBS -e $PBS_JOBID.bbduk_KTrim.stderr
#PBS -o $PBS_JOBID.bbduk_KTrim.stdout
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
echo Working directory is $PBS_O_WORKDIR
cd $PBS_O_WORKDIR
 
# This is where the work is done
# This script is used in Step 1 of the binning workflow which removes adapter sequence.
# Remember to specify your adapters with literal=Adapter1,Adapter2... or use reference adapters with ref=adapters.fa
# Remember to adjust forcetrimleft=3 according to your FASTQC reports
[ $# != 3 ] && { echo "Usage: qsub -F '<R1 FULL PATH> <R2 FULL PATH> <OUTPUT DIR> qsub_bbduk_KTrim.sh"; exit 1; }

R1=$1
R1_pure=$(echo "$R1" | rev | cut -f1 -d'/' | rev)
R2=$2
R2_pure=$(echo "$R2" | rev | cut -f1 -d'/' | rev)
OUTDIR=$3
mkdir -p "$OUTDIR"
/home/projects/<Your group>/data/Bin/Programs/bbmap/bbduk.sh in1="$R1" in2="$R2" out1="$OUTDIR"/"$R1_pure" out2="$OUTDIR"/"$R2_pure" literal=AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT,GATCGGAAGAGCACACGTCTGAACTCCAGTCACNNNNNNATCTCGTATGCCGTCTTCTGCTTG  ktrim=r k=23 mink=11 hdist=1 hdist2=0 forcetrimleft=3 tpe tbo 
