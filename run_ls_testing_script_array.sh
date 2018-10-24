#!/bin/bash
bash /data/DSST/ls_logging/scripts/ls_test.sh
/usr/local/slurm/bin/sbatch /data/DSST/ls_logging/scripts/ls_test.sh --constraint=ibfdr
/usr/local/slurm/bin/sbatch /data/DSST/ls_logging/scripts/ls_test.sh --constraint=10g