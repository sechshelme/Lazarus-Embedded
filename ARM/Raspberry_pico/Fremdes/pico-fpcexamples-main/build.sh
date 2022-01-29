#!/bin/sh
IGNOREDEVICES="templates "
curdir=$(pwd)
rm -f results 2>/dev/null
ls $1/*.lpi | while read lpi ; do
    echo ##### $lpi
    echo $IGNOREDEVICES | grep $(basename $lpi | sed -e "s,^.*-,," -e "s,.lpi,,g") >/dev/null
    if [ "$?" != 0 ]; then  
      echo "Building $lpi"
      cd $curdir/$(dirname $lpi)
#      lazbuild --build-all $(basename $lpi) | grep -v Hint | grep -v Info | grep -v Note | grep -v Warning | grep -v TCodeToolManager.HandleException | grep -v Compiling | grep -v "Linking" | grep -v "Assembling"
      $HOME/fpcupdeluxe/lazarus/lazbuild --build-all $(basename $lpi) | grep -e "lines compiled" -e Fatal -e "Illegal parameter"
      echo ""
    fi
done
echo ""
