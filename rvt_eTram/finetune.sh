#!/bin/bash

#SBATCH -N 1            # number of nodes
#SBATCH -c 1            # number of cores
#SBATCH -t 2-00:00:00   # time in d-hh:mm:ss
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

python finetune.py model=rnndet dataset='gen4' +checkpoint='./checkpoints/1mp/rvt-b.ckpt' dataset.path='/scratch/avaghel3/etrap_gen4' wandb.project_name=RVT wandb.group_name=eTrapfinetune hardware.gpus=0 +experiment/gen4='default.yaml' batch_size.train=10 batch_size.eval=3 hardware.num_workers.train=1 hardware.num_workers.eval=1 training.max_epochs=10 dataset.train.sampling=stream +model.head.num_classes=3
