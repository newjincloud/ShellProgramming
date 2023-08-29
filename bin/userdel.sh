#!/bin/bash

#!/bin/bash

USERLIST=user.list
cat $USERLIST | while read UNAME UPASS
do
    userdel -r $UNAME > /dev/null 2>&1 \
        && echo "[  OK  ] $UNAME removed." \
        || echo "[ FAIL ] $UNAME not removed."
done