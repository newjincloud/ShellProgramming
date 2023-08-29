#!/bin/bash
#         *
#       * * *
#     * * * * *
#   * * * * * * *
# * * * * * * * * *
for i in $(seq 1 5)
do
    # (상)오른쪽 공백 개수
    for k in $(seq $(expr 5 - $i) -1 1)
    do
        echo -n ' '
    done
    # (상)왼쪽 별 개수
    for j in $(seq 1 $i)
    do
        echo -n '*'
    done
    # (상)오른쪽 별 개수
    for l in $(seq 1 $(expr $i - 1))
    do
        echo -n '*'
    done
    echo
done