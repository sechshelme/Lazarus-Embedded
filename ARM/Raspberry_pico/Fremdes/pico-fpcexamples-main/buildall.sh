#!/bin/sh
IGNOREDEVICES="templates "
FILTER=$1
curdir=$(pwd)
ls -1 */*${FILTER}*lpi | while read lpi ; do
  echo $IGNOREDEVICES | grep $(basename $lpi | sed -e "s,^.*-,," -e "s,.lpi,,g") >/dev/null
  if [ "$?" != 0 ]; then  
    printf "Building %-60s" $lpi
    cd $curdir/$(dirname $lpi)
#    lazbuild --build-all $(basename $lpi) | grep -v Hint | grep -v Info | grep -v Note | grep -v Warning | grep -v TCodeToolManager.HandleException | grep -v Compiling | grep -v "Linking" | grep -v "Assembling"
    $HOME/fpcupdeluxe/lazarus/lazbuild --build-all $(basename $lpi) >../compile
    if [ "$?" != "0" ]; then
      echo "[FAILED]"
      rm -f ../compile 2>/dev/null
    else
      printf "[OK]    "
      cat ../compile  | grep "lines compiled" | sed "s~^.*sec,~~g"
      rm -f ../compile 2>/dev/null
    fi
  fi
done
echo ""
