#!/bin/bash

export JAVA_HOME=[path-to-spoutvm]

[path-to-kotlin]/bin/kotlin -J"-truffle" -J"-ea" $@
