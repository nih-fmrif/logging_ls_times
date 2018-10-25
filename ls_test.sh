#!/bin/bash
HOST_ID=$(hostname -s)
BASE_DIR=/data/DSST/ls_logging
# the following line is not working properly
NODE_TYPE=$(if [  $(/sbin/ip neigh |head -n1|grep -iq ib0) ];then echo "ibfdr_nodes/";else echo "other_nodes/";fi)
LOGFILE=${BASE_DIR}/${NODE_TYPE}ls_logs_${HOST_ID}.txt

# This is a list of different shares that captures a number of partitions
DIRLIST=(/data/CMI_preproc /data/DSST /data/DSST_dua /data/Dnude /data/FMRIF /data/HCP /data/Hbnssi /data/Hippo_ETPB /data/Hippo_hr /data/Histed_imaging /data/MLDSST /data/MLcore /data/NDAR /data/NIMH_MHSNIR /data/NIMH_PROTOCOL /data/NIMH_SFIM /data/NNDSP /data/SFIM /data/Xscanner /data/finnes /data/handwerkerd /data/jangrawdc /data/javiergc $HOME)

TIME=$(date --rfc-3339=seconds | sed 's/ /T/')

# Capture squeue information to assess whether particular users correlate with
# slow access times
/usr/local/slurm/bin/squeue  > ${BASE_DIR}/squeue_logs/${HOST_ID}_${TIME}_squeue.txt

# Write the time of this run into the logfile
echo Date run: $TIME >> $LOGFILE


for DIRECTORY in ${DIRLIST[*]};
do
    # For each directory this times the execution of an ls command, and
    # reports the number of files that were returned
    echo $(readlink ${DIRECTORY}) >> $LOGFILE  && (time (ls ${DIRECTORY}/*/* 2>/dev/null) | grep - | wc -l >> $LOGFILE) 2>>$LOGFILE
done
