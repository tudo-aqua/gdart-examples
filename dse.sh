#!/bin/sh

basedir=`dirname "$0"`

java -jar $basedir/dse/target/dse-0.0.1-SNAPSHOT-jar-with-dependencies.jar "$@"
