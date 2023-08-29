#!/bin/bash

max=5
for i in $(seq 1 $max)
do
    # (상)공백 개수
    for k in $(seq $(expr "$max" - "$i") -1 1)
    do
        echo -n ' '
    done
    # (상)별 개수(왼쪽)
    for j in $(seq 1 "$i")
    do
        echo -n '*'
    done
    # (상)별 개수(오른쪽)
    for k in $(seq 1 $(expr "$i" - 1))
    do
        echo -n '*'
    done
    echo
done

for i in $(seq 1 $max)
do
    # (하)공백 개수
    for l in $(seq 1 $i)
    do
        echo -n ' '
    done
    # (하)별 개수(왼쪽)
    for m in $(seq $(expr $max - $i) -1 1)
    do
        echo -n '*'
    done
    # (하)별 개수(오른쪽)
    for n in $(seq 1 $(expr $max - $i - 1))
    do
        echo -n '*'
    done
    echo
done
