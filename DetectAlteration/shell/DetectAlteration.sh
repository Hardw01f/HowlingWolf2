#/bin/sh

if [ $# -ne 2 ]; then
    echo "[WARNING] : You need specify TargetDirectory and Originlist as argument
USAGE: DetectAlteration.sh [MONITOR_TARGET_DIR] [ORIGIN_LIST]
If you had not originlist, You run CreateOriginList.sh before run this script"
    exit 1
fi

TARGETDIR=$1
ORIGINDIR=$2

results=`find $TARGETDIR -type file -exec md5 {} \; | awk '{print $2,$4}'`

while read result
do
    fullpaths=`echo "$result" | cut -d " " -f 1`
    hashes=`echo "$result" | cut -d " " -f 2`

    paths=`echo "$fullpaths" | sed -e 's/)//g' -e 's/(//g'`

    #echo $paths $hashes

    greped=`grep $paths $ORIGINDIR`
    if [ $? == 1 ]; then
        echo "[ALERT] : Putting New file named $paths"
    else
        listsHash=`echo $greped | cut -d " " -f 2`
        if [ $listsHash != $hashes ]; then
            NOWTIME=`date +%Y-%m-%d,%H:%M:%S`
            echo "[ALERT] : Detected Alteration in $paths at $NOWTIME"
        fi
    fi

done << RES
$results
RES

