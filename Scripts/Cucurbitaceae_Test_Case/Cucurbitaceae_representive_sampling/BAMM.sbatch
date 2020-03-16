#!/bin/bash
#SBATCH --job-name=OhBusy
#SBATCH --mail-type=ALL
#SBATCH --mail-user=user@ufl.edu
#SBATCH -o BAMM_genus_%j.out
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=64mb
#SBATCH -t 96:00:00
##SBATCH --array=1-40
###SBATCH -t 1-200%5
###SBATCH --partition=hpg1-compute
#SBATCH --qos=soltis-b

module load gcc/5.2.0 bamm

bamm -c Cucurbitaceae_5g_genus_diversification.config
