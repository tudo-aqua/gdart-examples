#!/bin/bash

export JAVA_HOME=[path-to-graalvm]

[path-to-spoutvm]/bin/java -truffle -ea $@
