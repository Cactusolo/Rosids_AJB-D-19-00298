#!/bin/bash
#SBATCH --job-name=OhBusy
#SBATCH --mail-type=ALL
#SBATCH --mail-user=cactus@ufl.edu
#SBATCH -o BAMM_%A_%a.out
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=128mb
#SBATCH -t 96:00:00
#SBATCH --array=1-17
###SBATCH -t 1-200%5
###SBATCH --partition=hpg1-compute
#SBATCH --qos=soltis-b

module load gcc/5.2.0 bamm

order=$(sed -n ${SLURM_ARRAY_TASK_ID}p Order)

cd $order

bamm -c ${order}_PB_diversification.config

cd ..


