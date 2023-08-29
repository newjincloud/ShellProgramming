#!/bin/bash

: << EOF
for LINE in $(cat input.txt)
do
    echo $LINE
done
EOF

# : << EOF
cat input.txt | while read NUM ORDER LINE
do
    echo $NUM $ORDER $LINE
done
# EOF
