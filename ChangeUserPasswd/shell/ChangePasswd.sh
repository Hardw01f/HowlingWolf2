#!/bin/sh

if [ $# -ne 2 ]; then
    echo "[WARNING] : You need to specific number of user changed password and Password list file as argument
    USAGE: ChangePasswd.sh [NUNBER_OF_USER(NOT CONTAIN 'root' USER)] [PASSWORD_LIST_FILE]"
    exit 1
fi

if [ `whoami` != "root" ]; then
    echo "[ERROR] : You need to run as root user"
    exit 1
fi

USERNUM=$1
PASSWDLISTS=$2

passwdCount=`cat $PASSWDLISTS | wc -l`
if [ "$passwdCount" -ne `expr $USERNUM + 1` ]; then
    echo "[ERROR] : The number of passwords in $PASSWDLISTS list NOT MATCHES the number of users who change the specified password"
    exit 1
fi
echo "[OK] : The number of passwords in $PASSWDLISTS list MATCHES the number of users who change the specified password"

osName=`uname`
if [ $osName == 'Darwin' ]; then
    echo "[ERROR] : You try to run Change User Password on Macbook local pc, Abort Changing Password"
    exit 1
elif [ $osName == 'Linux' ]; then
    echo "[OK] : Your OS : $osName"
fi

echo "Going to change root and user password , OK?  [ Yes/no ]"
read answer
if [ $answer != 'Yes' ]; then
    echo "Abort changing user password"
    exit 1
fi

rootPasswd=`sed -n 1p $PASSWDLISTS`
echo "echo 'root:$rootPasswd' | chpasswd"
echo "root:$rootPasswd" | chpasswd
if [ $? == 0 ]; then
    echo "[OK] : root passwd change was successful!"
fi

for num in `seq 1 $USERNUM`
do
    passwdLine=`expr $num + 1`
    userPasswd=`sed -n $passwdLine"p" $PASSWDLISTS`
    echo "echo 'user$num:$userPasswd' | chpasswd"
    echo "user$num:$userPasswd" | chpasswd
    if [ $? == 0 ]; then
        echo "[OK] : user$num passwd change was successful!"
    fi
done
