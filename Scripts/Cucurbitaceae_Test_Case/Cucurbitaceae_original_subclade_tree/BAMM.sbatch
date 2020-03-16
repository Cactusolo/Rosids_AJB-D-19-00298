#!/bin/bash
#SBATCH --job-name=OhBux
#SBATCH --mail-type=ALL
#SBATCH --mail-user=user@ufl.edu
#SBATCH -o BAMM_genus_%j.out
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=128mb
#SBATCH -t 200:00:00
##SBATCH --array=1-40
###SBATCH -t 1-200%5
###SBATCH --partition=hpg1-compute


module load gcc/5.2.0 bamm

bamm -c  Cucurbitaceae_5g_family_diversification.config
