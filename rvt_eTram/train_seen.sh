#!/bin/bash

#SBATCH -N 1            # number of nodes
#SBATCH -c 4            # number of cores
#SBATCH -t 4-00:00:00   # time in d-hh:mm:ss
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

source activate rvt

python train.py model=rnndet dataset=gen4 dataset.path=/scratch/avaghel3/etrap_seen/ \
	wandb.project_name=RVT wandb.group_name=etrap_seeen \
	+experiment/gen4="default.yaml" hardware.gpus=0 batch_size.train=4 \
	batch_size.eval=3 hardware.num_workers.train=4 hardware.num_workers.eval=1 \
	training.max_epochs=20 dataset.train.sampling=stream +model.head.num_classes=3
