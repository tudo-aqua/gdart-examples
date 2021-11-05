#!/bin/bash

DIR=$(dirname $BASH_SOURCE)
source $DIR/gdart-examples.sh

$SPOUT_HOME/bin/java -truffle -ea "$@"
