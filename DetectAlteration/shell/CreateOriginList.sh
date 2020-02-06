#/bin/sh

if [ $# -ne 1 ]; then
    echo "[WARNING] : To craete Originlist, You need specify Directory where you want to detect alteration as argument
USAGE: DetectAlteration.sh [DIR]"
    exit 1
fi

TARGETDIR=$1
NOWTIME=`date +%Y%m%d_%H:%M`

if [ -e $1_*.origin ]; then
    echo "already exist originlist"
    exit 1
else
    echo "Now Creating $1_$NOWTIME*.origin"
    echo $NOWTIME
    touch ./$1_$NOWTIME.origin
fi


results=`find $TARGETDIR -type file -exec md5 {} \; | awk '{print $2,$4}'`

while read result
do
    fullpaths=`echo "$result" | cut -d " " -f 1`
    hashes=`echo "$result" | cut -d " " -f 2`

    paths=`echo "$fullpaths" | sed -e 's/)//g' -e 's/(//g'`

    echo $paths $hashes >> ./$1_$NOWTIME.origin 
    echo $paths $hashes 

done << RES
$results
RES

