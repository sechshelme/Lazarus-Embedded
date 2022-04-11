#!/bin/sh
for file in * ; do
  if [ -d $file -a $file != "templates" -a $file != "units" ]; then
    ./genlpi.sh $file
  fi
done

