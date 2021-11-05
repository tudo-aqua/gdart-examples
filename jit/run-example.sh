#!/bin/bash

source ../gdart-examples.sh

javac -cp $VERIFIER_STUB_CP Main.java

printf "\n\nRunning the jit demonstration with normal Java: \n\n"
java -ea -cp $VERIFIER_STUB_CP:. Main

printf "\n\n Running the jit demonstration with SPouT: \n\n"
../spout.sh -cp $VERIFIER_STUB_CP:. Main
