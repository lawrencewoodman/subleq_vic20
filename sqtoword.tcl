#! /usr/bin/env tclsh
#
# Convert SUBLEQ .sq files to a series of .word statements
# for including into a .a65 file
#
# Copyright (C) 2020 Lawrence Woodman <lwoodman@vlifesystems.com>
# Licensed under an MIT licence.  Please see LICENCE.md for details.


proc readFile {filename} {
  set fp [open $filename r]
  set data [read $fp]
  close $fp
  return $data
}

proc toWords {src numSpaces} {
  set numsPerLine 10
  set line [list]
  foreach v $src {
    if {[string is integer $v]} {
      lappend line $v
      if {[llength $line] == $numsPerLine} {
        puts "[string repeat " " $numSpaces].word [join $line ","]"
        set line [list]
      }
    }
  }
  if {[llength $line] >= 0} {
        puts "[string repeat " " $numSpaces].word [join $line ","]"
  }
}


proc getParams {_args} {
  set cmd [file tail [info script]]
  set usage "Usage: $cmd \[OPTION]... filename
Convert SUBLEQ .sq files to a series of .word statements

Arguments:
  -n numSpaces     Number of spaces to indent each line
  -h               Display this help and exit
  --               Mark the end of switches
"

  array set params {indentNumSpaces 0}
  while {[llength $_args]} {
    switch -glob -- [lindex $_args 0] {
      -n   {set _args [lassign $_args - params(indentNumSpaces)]}
      -h   {
        puts $usage
        set _args [lrange $_args 1 end]
        exit 0
      }
      --   {set _args [lrange $_args 1 end] ; break}
      -*   {
        return -code error "Unknown option: [lindex $_args 0]"
      }
      default break
    }
  }
  if {[llength $_args] == 0} {
    return -code error "Please supply filename"
  }
  if {[llength $_args] > 1} {
    return -code error "Too many arguments"
  }
  set params(srcFilename) [lindex $_args 0]
  return [array get params]
}

set cmd [file tail [info script]]

try {
  set params [getParams $argv]
  set srcFilename [dict get $params srcFilename]
  set src [readFile $srcFilename]
} on error {err} {
  puts stderr "$cmd: $err"
  puts stderr "Try '$cmd -h' for more information."
  exit 1
}

toWords $src [dict get $params indentNumSpaces]
