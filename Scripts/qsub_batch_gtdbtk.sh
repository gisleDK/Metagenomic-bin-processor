#!/bin/sh
### Note: No commands may be executed until after the #PBS lines
### Account information
#PBS -W group_list=cu_10108 -A cu_10108
### Job name (comment out the next line to get the name of the script used as the job name)
#PBS -N qsub_batch_gtdbtk
### Output files (comment out the next 2 lines to get the job name used instead)
#PBS -e $PBS_JOBID.qsub_batch_gtdbtk.stderr
#PBS -o $PBS_JOBID.qsub_batch_gtdbtk.stdout
### Only send mail when job is aborted or terminates abnormally
#PBS -m n
### Number of nodes
#PBS -l nodes=1:ppn=1:thinnode
### Requesting time - format is <days>:<hours>:<minutes>:<seconds> (here, 30 days)
#PBS -l walltime=30:00:00:00
# V1.00 Written by Gisle Vestergaard (gislevestergaard@gmail.com)

# This is where the work is done
# Because GTDB-tk has problems with larger amounts of bins, this scripts splits bins up and
# feeds them in batches of 1000 to gtdb-tk
[ $# != 1 ] && { echo "Usage: qsub -F '<bin DIR> ' qsub_batch_gtdbtk.sh"; exit 1; }
INDIR=$1
cd "$INDIR"
ls | grep -E 'bins_[0-9]{3}$' > dirs.list
parallel "qsub -F '{} {}_gtdbtk' /home/people/gisves/Github/Metagenomic-bin-processor/Scripts/qsub_gtdbtk.sh" :::: dirs.list
rm -f dirs.list
