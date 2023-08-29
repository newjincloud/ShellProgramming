#!/bin/bash
#         *
#       * *
#     * * *
#   * * * *
# * * * * *

for i in $(seq 1 5)
do
    for k in $(seq $(expr 5 - $i) -1 1)
    do
        echo -n ' '
    done
    for j in $(seq 1 $i)
    do
        echo -n '*'
    done
    echo
done