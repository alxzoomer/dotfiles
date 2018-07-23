#!/bin/bash

if [ -z $OSTYPE ] ; then
  OSTYPE="$(uname -o)"
fi

case "$OSTYPE" in
  solaris*) echo "SOLARIS" ;;
  darwin*)  echo "OSX" ;; 
  linux*)   echo "LINUX" ;;
  Linux*)   OS=LINUX ;;
  bsd*)     echo "BSD" ;;
  *)        echo "unknown" ;;
esac
