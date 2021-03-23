#!/bin/sh
### Note: No commands may be executed until after the #PBS lines
### Account information
#PBS -W group_list=cu_10108 -A cu_10108
### Job name (comment out the next line to get the name of the script used as the job name)
#PBS -N qsub_batch_checkm
### Output files (comment out the next 2 lines to get the job name used instead)
#PBS -e $PBS_JOBID.qsub_batch_checkm.stderr
#PBS -o $PBS_JOBID.qsub_batch_checkm.stdout
### Only send mail when job is aborted or terminates abnormally
#PBS -m n
### Number of nodes
#PBS -l nodes=1:ppn=1:thinnode
### Requesting time - format is <days>:<hours>:<minutes>:<seconds> (here, 30 days)
#PBS -l walltime=30:00:00:00
# V1.00 Written by Gisle Vestergaard (gislevestergaard@gmail.com)

# This is where the work is done
# Because CheckM has problems with larger amounts of bins, this scripts splits bins up and
#  feeds them in batches of 1000 to checkm
[ $# != 1 ] && { echo "Usage: qsub -F '<bin DIR> ' qsub_batch_checkm.sh"; exit 1; }
INDIR=$1
cd "$INDIR"
INDIR_PURE=$(echo "$INDIR" | rev | cut -f 1 -d '/' | rev)
i=0; for f in *.fna; do d=bins_$(printf %03d $((i/1000+1))); mkdir -p $d; mv "$f" $d; let i++; done
ls | grep bins_ > dirs.list
parallel "qsub -F '{} {}_checkm' /home/people/gisves/Github/Metagenomic-bin-processor/Scripts/qsub_checkm.sh" :::: dirs.list
rm -f dirs.list
