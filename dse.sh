#!/bin/sh

basedir=`dirname "$0"`

source $basedir/gdart-examples.sh

java -jar $DSE_JAR "$@"
