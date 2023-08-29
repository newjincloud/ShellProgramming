#!/bin/bash

IP1="192.168.10.10"
#IP1=""
if [ "$IP1" = "" ] ; then
    echo "[  OK  ] NULL."
else
    echo "[  OK  ] Not null."
fi