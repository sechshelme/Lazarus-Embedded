#!/bin/sh
APPNAME=$1

if [ -z "$1" ]; then
	echo Usage: 
	echo genlpi.sh Projectname
	exit 1
fi

if [ ! -d $APPNAME ]; then
  echo Project "$APPNAME" does not exist in current directory
  exit 1
fi

rm -f $APPNAME/*.lpi

cat devicelist | grep -v "^#" | while read BOARD_OR_CPU SUBARCH DEVICE DEVICESVD; do
  ARCH=
  ARCHSVD=
  BINUTILS_PATH=

  if [ "$SUBARCH" = armv6m ]; then
    ARCH=arm
    ARCHSVD=Cortex-M0.svd
  fi

  if [ "$SUBARCH" = armv7m ]; then
    ARCH=arm
    ARCHSVD=Cortex-M3.svd
  fi

  if [ "$SUBARCH" = armv7em ]; then
    ARCH=arm
    ARCHSVD=Cortex-M4.svd
    EXTRACUSTOMOPTION1="-Sg -CfFPV4_SP_D16"
  fi

  DONOTGENERATE=
  if [ -f $APPNAME/devicelist.ignore ]; then
    grep "$BOARD_OR_CPU" $APPNAME/devicelist.ignore >/dev/null
    if [ "$?" == "0" ]; then
      DONOTGENERATE=yes
    fi
  fi
  if [ -z "$DONOTGENERATE" ]; then
    cat templates/template.lpi | sed -e "s,%%APPNAME%%,$APPNAME,g" \
                         -e "s,%%ARCH%%,$ARCH,g" \
                         -e "s,%%SUBARCH%%,$SUBARCH,g" \
                         -e "s,%%BOARD_OR_CPU%%,$BOARD_OR_CPU,g" >$APPNAME/$APPNAME.lpi
                         #-e "s,%%BOARD_OR_CPU%%,$BOARD_OR_CPU,g" >$APPNAME/$APPNAME-$BOARD_OR_CPU.lpi
    echo $APPNAME/$APPNAME.lpi created
    #echo $APPNAME/$APPNAME-$BOARD_OR_CPU.lpi created
  fi

  if [ ! -f $APPNAME/$APPNAME.lpr ]; then
    cat templates/template.lpr | sed "s,%%APPNAME%%,$APPNAME,g" >$APPNAME/$APPNAME.lpr
    echo $APPNAME/$APPNAME.lpr created
  fi
done
