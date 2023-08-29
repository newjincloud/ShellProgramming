#!/bin/bash
# ex) check_report.sh 1

if [ $# -ne 1 ] ; then
    echo "Usage: $0 {1|2|3|...}"
    exit 1
fi
NUM=$1

# Variable definition
REPORT=report.txt
NEXTNUM=$(expr $NUM + 1)

# sed -n '/U-1/,/U-2/p' $REPORT
sed -n "/U-$NUM/,/U-$NEXTNUM/p" $REPORT | sed '$d'

