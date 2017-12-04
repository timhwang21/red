#!/bin/bash

usage() {
    cat <<EOM
    NAME
         red -- range editor

    SYNOPSIS
         red start end input [output]

    DESCRIPTION
         Loads a range of a given file into vim, and either writes in place, or
         writes to a new file.

         Useful for making precise edits to predetermined ranges in large
         (~100mb) files without having to load the entire file into memory.

    EXAMPLES
         red 1 20 largefile.txt
EOM
    exit 0
}

red() {
  local start=$1
  local end=$2
  local input=$3
  local output=$4

  local tmp="/tmp/red_${start},${end}_$$"
  local tmp_out="/tmp/red_out_$$"

  # slice large file and pass to vim
  sed -n ${start},${end}p $input > $tmp
  vim $tmp

  # splice edited file into old file
  {
    # do not call head when range starts at line 1
    [[ $start = 1 ]] || head -n $(( $start - 1 )) $input ;
    cat $tmp ;
    tail -n +$(( $end + 1 )) $input ;
  } > $tmp_out

  # Write to $output if provided else overwrite $input
  mv -f $tmp_out ${output:-$input}

  # cleanup
  rm -f $tmp
}

[ -z $1 ] && { usage ; } || { red "$@" ; }
