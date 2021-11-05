#!/bin/bash

DIR=$(dirname $BASH_SOURCE)
source $DIR/gdart-examples.sh

java -jar $DSE_JAR "$@"
