#!/bin/bash
bash /data/DSST/ls_logging/scripts/ls_test.sh
# can add ibfdr nodes if there is a way to detect which network interface is
# being used. should be easy. I encountered a silly bug
# /usr/local/slurm/bin/sbatch /data/DSST/ls_logging/scripts/ls_test.sh --constraint=ibfdr
/usr/local/slurm/bin/sbatch /data/DSST/ls_logging/scripts/ls_test.sh --constraint=10g