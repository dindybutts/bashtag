#!/usr/bin/env bash
#
# bashtag.sh
# Copyright (C) 2018 DNDEBUG <lewdavatar@gmail.com>
#
# Distributed under terms of the GPLv3 license.
#


# usage: bashtag {file} {tag1} {tag2} {tag3} (etc etc)

set -o errexit
# realpath is an external program, check if it's installed first

# 0 is the file path
# 1 is the first tag
# anything past 1 is other tags
argument_array=( "$@" )

if [ "${#argument_array[@]}" -ge 2 ]
then
  # this gets all the tags
  for (( i = 1; i < ${#argument_array[@]}; i++ ))
  do

    if [ ! -f "$HOME/tags/${argument_array[$i]}/$(basename "$1")" ]
    then
      mkdir -p "$HOME/tags/${argument_array[$i]}"
      echo "$HOME/tags/${argument_array[$i]}/$(basename "$1")"
      ln -s "$(realpath "$1")" "$HOME/tags/${argument_array[$i]}/$(basename "$1")"
    else
      echo "symlink at $HOME/tags/${argument_array[$i]}/$(basename "$1") exists"
    fi

  done
elif [ "${#argument_array[@]}" -lt 2 ]
then

  echo "Error: No tag specified"
  exit 1

fi
