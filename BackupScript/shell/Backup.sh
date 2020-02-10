#!/bin/sh

if [ `whoami` != "root" ]; then
    echo "[ERROR] : You need to run as root user"
    exit 1
fi


osName=`uname`
if [ $osName == 'Darwin' ]; then
    echo "[ERROR] : You try to get Backup on Macbook local pc, Abort Getting Backup"
    exit 1
elif [ $osName == 'Linux' ]; then
    echo "[OK] : Your OS : $osName"
fi

echo "Going to Get Backup, OK?  [ Yes/no ]"
read answer
if [ $answer != 'Yes' ]; then
    echo "Abort Getting Bakcup"
    exit 1
fi

echo "Starting Get Backup"
echo ""

mkdir /backup
if [ $? == 0 ]; then
    echo "[OK] : Created /backup Directory"
else
    echo "[ERROR] : Creating /backup Directory was FAILED..." 
fi

mkdir /backup/etc
if [ $? == 0 ]; then
    echo "[OK] : Created /backup/etc Directory"
else
    echo "[ERROR] : Creating /backup/etc Directory was FAILED..." 
fi

mkdir /backup/www
if [ $? == 0 ]; then
    echo "[OK] : Created /backup/www Directory"
else
    echo "[ERROR] : Creating /backup/www Directory was FAILED..." 
fi

cp -r /etc /backup
if [ $? == 0 ]; then
    echo "[OK] : Getting Backup of /etc Dir to /backup/etc"
else
    echo "[ERROR] : Getting /etc Backup was FAILED..." 
fi

cp -r /var/www /backup/www
if [ $? == 0 ]; then
    echo "[OK] : Getting Backup of /var/www Dir to /backup/www"
else
    echo "[ERROR] : Getting /var/www Backup was FAILED..." 
fi

