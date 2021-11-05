#!/bin/bash
source ../gdart-examples.sh

pushd ../../deps;
    unzip -o scala3-3.1.0-RC2.zip
popd;

export JAVA_HOME=$SPOUT_HOME

$SCALA_HOME/bin/scalac -cp $VERIFIER_STUB_CP Main.scala

printf "\n\n Running the scala example with SPouT: \n\n"
export JAVACMD=./java.sh
export JAVA_OPTS=
$SCALA_HOME/bin/scala -cp $VERIFIER_STUB_CP Hello

printf "\n\n Seeding Values to the scala example with SPouT: \n\n"


export JAVA_OPTS="-Dconcolic.ints=1"
$SCALA_HOME/bin/scala -cp $VERIFIER_STUB_CP Hello


printf "\n\n Running the Concolic Analysis \n\n:"
../dse.sh -Ddse.executor=./executor.sh -Ddse.dp=multi "-Ddse.executor.args=-cp $VERIFIER_STUB_CP Hello"
