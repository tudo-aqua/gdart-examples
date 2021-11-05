#!/bin/bash
source ../gdart-examples.sh

pushd ../../deps;
    unzip -o kotlin-compiler-1.5.31.zip
popd;

export JAVA_HOME=$SPOUT_HOME

$KOTLIN_HOME/bin/kotlinc -cp $VERIFIER_STUB_CP Main.kt

printf "\n\n Running the kotlin example with SPouT: \n\n"

$KOTLIN_HOME/bin/kotlin -J"-truffle" -J"-ea" -cp $VERIFIER_STUB_CP:. MainKt

printf "\n\n Seeding Values to the kotlin example with SPouT: \n\n"

$KOTLIN_HOME/bin/kotlin -J"-truffle" -J"-ea" -cp $VERIFIER_STUB_CP:. -Dconcolic.ints=1 MainKt


printf "\n\n Running the Concolic Analysis \n\n:"
../dse.sh -Ddse.executor=./executor.sh -Ddse.dp=multi "-Ddse.executor.args=-cp $VERIFIER_STUB_CP:. MainKt"
