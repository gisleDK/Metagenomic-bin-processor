#!/bin/sh
### Note: No commands may be executed until after the #PBS lines
### Account information
#PBS -W group_list=cu_10108 -A cu_10108
### Job name (comment out the next line to get the name of the script used as the job name)
#PBS -N qsub_checkm_summary
### Output files (comment out the next 2 lines to get the job name used instead)
#PBS -e $PBS_JOBID.qsub_checkm_summary.stderr
#PBS -o $PBS_JOBID.qsub_checkm_summary.stdout
### Only send mail when job is aborted or terminates abnormally
#PBS -m n
### Number of nodes
#PBS -l nodes=1:ppn=1:thinnode
### Requesting time - format is <days>:<hours>:<minutes>:<seconds> (here, 30 days)
#PBS -l walltime=30:00:00:00
# V1.00 Written by Gisle Vestergaard (gislevestergaard@gmail.com)

# This is where the work is done
# This merges the results from the previously split CheckM runs and makes a figure of all bins.
[ $# != 1 ] && { echo "Usage: qsub -F '<bin DIR> ' qsub_checkm_summary.sh"; exit 1; }
INDIR=$1
cd $INDIR
rm -f allbins_checkm_qa.tsv
cat bins_*_checkm/*_checkm_qa.tsv awk | awk '!x[$0]++' >> allbins_checkm_qa.tsv
Rscript /home/people/gisves/Github/Metagenomic-bin-processor/Bin/checkm_summary.r allbins_checkm_qa.tsv
cat allbins_checkm_qa.tsv | cut -f 1,6,7 | awk '$2>90' | awk '$3<5' > allbins_checkm_qa_HQ_bins.tsv
