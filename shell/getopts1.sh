#!/bin/bash

Usage() {
    echo "Usage: $0 [-x] [-y foo] file"
    exit 1
}

while getopts xy: options 2>/dev/null
do
    case $options in
        x) echo "[XXXX]" ;;
        y) echo "[YYYY] - $OPTARG" ;;
       \?) Usage ;;
        *) Usage ;;
    esac
done

shift $(expr $OPTIND - 1)
echo "$@"

if [ $# -eq 0 ]; then
    Usage
fi
echo "$@: $1"
