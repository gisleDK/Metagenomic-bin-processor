#!/bin/sh
### Note: No commands may be executed until after the #PBS lines
### Account information
#PBS -W group_list=cu_10108 -A cu_10108
### Job name (comment out the next line to get the name of the script used as the job name)
#PBS -N snakemake
### Output files (comment out the next 2 lines to get the job name used instead)
#PBS -e snakemake.err
#PBS -o snakemake.log
### Number of nodes
#PBS -l nodes=1:ppn=40:thinnode,walltime=20:00:00
### Add current shell environment to job (comment out if not needed)
#PBS -V
#PBS -d /home/projects/cu_10108/people/trizac/VAMB_genes
##PBS -t 1-7

source /home/projects/cu_10108/people/trizac/bash_modules

snakemake --snakefile Snakefile_VAMBgenes --resources  mem_gb=1900 --cluster 'qsub -W group_list=cu_10108 -A cu_10108 -l nodes=1:ppn={threads},mem={resources.mem_gb}gb,walltime={resources.runtime} -V -d /home/projects/cu_10108/people/trizac/VAMB_genes' --directory /home/projects/cu_10108/people/trizac/VAMB_genes --jobs 100 --jobname "snake.{name}.{jobid}" --printshellcmds --latency-wait 20
