#!/bin/sh

if [ `whoami` != "root" ]; then
    echo "not root"
    exit 1
fi

USERNUM=$1
PASSWDLISTS=$2

passwdCount=`cat $PASSWDLISTS | wc -l`
if [ "$passwdCount" -ne `expr $USERNUM + 1` ]; then
    echo "[ERROR] : Not match $PASSWDLISTS user passwd counts to change user passwd counts"
    exit 1
fi

rootPasswd=`sed -n 1p $PASSWDLISTS`
echo "echo 'root:$rootPasswd' | chpasswd"
if [ $? == 0 ]; then
    echo "[OK] : root passwd change was successful!"
fi

for num in `seq 1 $USERNUM`
do
    passwdLine=`expr $num + 1`
    userPasswd=`sed -n $passwdLine"p" $PASSWDLISTS`
    echo "echo 'user$num:$userPasswd' | chpasswd"
    if [ $? == 0 ]; then
        echo "[OK] : user$num passwd change was successful!"
    fi
done
