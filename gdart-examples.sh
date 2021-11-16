#!/bin/bash

DIR=$(dirname $BASH_SOURCE)

SPOUT_HOME=$DIR/../gdart-svcomp/spout/sdk/mxbuild/linux-amd64/GRAALVM_ESPRESSO_NATIVE_CE_JAVA11/graalvm-espresso-native-ce-java11-21.2.0/

JAVA_HOME=$(realpath $SPOUT_HOME)

DSE_JAR=$DIR/../gdart-svcomp/dse/target/dse-0.0.1-SNAPSHOT-jar-with-dependencies.jar

VERIFIER_STUB_CP=$DIR/../gdart-svcomp/verifier-stub/target/verifier-stub-1.0.jar

# for kotlin example
#
KOTLIN_HOME=[[ SET PATH TO KOTLIN HOME ]]

# for scala example
#
SCALA_HOME=[[ SET PATH TO SCALA HOME ]]
