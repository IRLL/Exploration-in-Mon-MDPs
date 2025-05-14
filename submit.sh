#!/bin/bash
# ---------------------------------------------------------------------
# SLURM script for a multi-step job on our clusters.
# ---------------------------------------------------------------------
#SBATCH --mail-user=XXX
#SBATCH --mail-type=ALL
#SBATCH --signal=B:SIGTERM@180
#SBATCH --account=XXX
#SBATCH --nodes=1
#SBATCH --time=0:25:00
#SBATCH --mem=10000M
#SBATCH --cpus-per-task=32
#SBATCH --tasks-per-node=1
#SBATCH --job-name="48_benchmark_cedar"
# ---------------------------------------------------------------------
echo "Current working directory: `pwd`"
echo "Starting run at: `date`"
# ---------------------------------------------------------------------
# Run your simulation step here..

tar -xzf Exploration-in-Mon-MDPs.tar.gz -C $SLURM_TMPDIR/
tar -xzf dee_venv.tar.gz -C $SLURM_TMPDIR/Exploration-in-Mon-MDPs/
cd $SLURM_TMPDIR/Exploration-in-Mon-MDPs/ || exit

./run.sh "48_benchmark" default

tar -cavf Mon-MBIE-EB/figs.tar.xz figs
cp Mon-MBIE-EB/figs.tar.xz ~/scratch/figs_$SLURM_JOB_NAME.tar.xz

tar -cavf data.tar.xz Mon-MBIE-EB/data
cp data.tar.xz ~/scratch/data_$SLURM_JOB_NAME.tar.xz

# ---------------------------------------------------------------------
echo "Wrapping up run at: `date`"
# ---------------------------------------------------------------------

# seff $JOB_ID


