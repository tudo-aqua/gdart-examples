#!/bin/bash

source ../gdart-examples.sh
javac -cp $VERIFIER_STUB_CP Main.java
printf "\n\nRunning the example without any seeded values:\n\n"
../spout.sh -cp $VERIFIER_STUB_CP:. Main
printf "\n\nRunning the example with 101 as seeded value:\n\n"
../spout.sh -cp $VERIFIER_STUB_CP:. -Dconcolic.ints=101 Main
printf "\n\nRunning the full analysis:\n\n"
../dse.sh -Ddse.executor=./executor.sh -Ddse.dp=multi "-Ddse.executor.args=-cp $VERIFIER_STUB_CP:. Main"
