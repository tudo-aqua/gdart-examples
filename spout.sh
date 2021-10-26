#!/bin/sh

basedir=`dirname "$0"`

source $basedir/gdart-examples.sh

$SPOUT_HOME/bin/java -truffle -ea "$@"
