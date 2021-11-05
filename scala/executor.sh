#!/bin/bash

source ../gdart-examples.sh
export JAVA_HOME=$SPOUT_HOME

OPTS=""
REMAINDER=""
for i in $@; do
    if [[ $i == -D* ]]; then
        OPTS+=" ${i}";
    else
        REMAINDER+=" ${i}";
    fi
done

echo "OPTS: ${OPTS}"
echo "REST: ${REMAINDER}"


export JAVA_OPTS=$OPTS
export JAVACMD=./java.sh

$SCALA_HOME/bin/scala $REMAINDER
