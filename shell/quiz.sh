#!/bin/bash

# Import the functions.sh
. /root/shell/functions.sh

# Variable Definition
MESSFILE=/root/shell/MESS.txt
RESULT=/root/shell/result.txt
> $RESULT
NUM=0

# Code Definition
for i in $(seq 3)
do
    NUM=$i
    MESS=$(sed -n "$i"p $MESSFILE)
    EvalLecture "$NUM" "$MESS"
done
echo 

