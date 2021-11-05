#!/bin/bash

source ../gdart-examples.sh
export JAVA_HOME=$SPOUT_HOME
$SPOUT_HOME/bin/java -truffle -ea $JAVA_OPTS $@
