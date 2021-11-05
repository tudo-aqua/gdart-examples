#!/bin/bash

source ../gdart-examples.sh
export JAVA_HOME=$SPOUT_HOME

$KOTLIN_HOME/bin/kotlin -J"-truffle" -J"-ea" $@
