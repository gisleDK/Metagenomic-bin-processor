#!/bin/sh
### Note: No commands may be executed until after the #PBS lines
### Account information
#PBS -W group_list=cu_10108 -A cu_10108
### Job name (comment out the next line to get the name of the script used as the job name)
#PBS -N snakemake
### Output files (comment out the next 2 lines to get the job name used instead)
#PBS -e /home/projects/cu_10108/people/trizac/HQ_clusters/logs/snakemake.err
#PBS -o /home/projects/cu_10108/people/trizac/HQ_clusters/logs/snakemake.log
### Number of nodes
#PBS -l nodes=1:ppn=40:thinnode,walltime=272:30:00
### Add current shell environment to job (comment out if not needed)
#PBS -V
#PBS -d /home/projects/cu_10108/people/trizac/HQ_clusters/
##PBS -t 1-7

source /home/projects/cu_10108/people/trizac/bash_modules

snakemake --snakefile /home/projects/cu_10108/people/trizac/Metagenomic-bin-processor/gene_count_matrix/Snakefile_VAMBgenes --resources mem_gb=2940 --cluster 'qsub -W group_list=cu_10108 -A cu_10108 -l nodes=1:ppn={threads},mem={resources.mem_gb}gb,walltime={resources.runtime} -V -d /home/projects/cu_10108/people/trizac -e /home/projects/cu_10108/people/trizac/HQ_clusters/logs/ -o /home/projects/cu_10108/people/trizac/HQ_clusters/logs/' --directory /home/projects/cu_10108/people/trizac --jobs 100 --jobname "snake.{name}.{jobid}" --printshellcmds --latency-wait 200

# Forcing rerun of rules with nuc instead of prot
#snakemake --snakefile /home/projects/cu_10108/people/trizac/Metagenomic-bin-processor/gene_count_matrix/Snakefile_VAMBgenes --resources  mem_gb=1900 --cluster 'qsub -W group_list=cu_10108 -A cu_10108 -l nodes=1:ppn={threads},mem={resources.mem_gb}gb,walltime={resources.runtime} -V -d /home/projects/cu_10108/people/trizac' --directory /home/projects/cu_10108/people/trizac --jobs 100 --jobname "snake.{name}.{jobid}" --printshellcmds --latency-wait 200 -R nonredundant_catalogue minimap_index minimap_align count_genes gene_names create_header gene_count_matrix gene_lists all
