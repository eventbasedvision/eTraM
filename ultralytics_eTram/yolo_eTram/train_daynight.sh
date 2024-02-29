#!/bin/bash

#SBATCH -N 1            # number of nodes
#SBATCH -c 8            # number of cores
#SBATCH -t 3-00:00:00   # time in d-hh:mm:ss
#SBATCH -G a100:1	# requesting one A100
#SBATCH -p general      # partition
#SBATCH -q public       # QOS
#SBATCH -o slurm.%j.out # file to save job's STDOUT (%j = JobId)
#SBATCH -e slurm.%j.err # file to save job's STDERR (%j = JobId)
#SBATCH --mail-type=ALL # Send an e-mail when a job starts, stops, or fails
#SBATCH --export=NONE   # Purge the job-submitting shell environment

# Load required modules for job's environment

module load mamba/latest
module load cuda-11.8.0-gcc-12.1.0

# Using python, so source activate an appropriate environment

source activate yolo

python main.py --data data_daynight.yaml --batch_size 128 --max_epoch 20 --test
