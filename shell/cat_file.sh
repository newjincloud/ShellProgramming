#!/bin/bash

for NAME in $(egrep -v '^#|^$' /etc/vsftpd/ftpusers)
do
    echo "$NAME"
done
