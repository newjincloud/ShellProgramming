#!/bin/bash
# ex) # move_filename2.sh /test .els .txt
#       -> *.els => *.txt

if [ $# -ne 3 ]; then
    echo "Usage: $0 <directory> <src extension> <dst extension>"
    exit 1
fi
D_WORK=$1
SRC_PATTERN=$2
DST_PATTERN=$3
T_FILE1=/tmp/.tmp1  	# tempory file1

ls -1 $D_WORK | grep "${SRC_PATTERN}$" > $T_FILE1
for FILE in `cat $T_FILE1`
do
    mv $D_WORK/$FILE `echo $D_WORK/$FILE | sed "s/${SRC_PATTERN}$/${DST_PATTERN}/g"`
done


