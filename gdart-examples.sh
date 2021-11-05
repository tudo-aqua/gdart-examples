#!/bin/bash

DIR=$(dirname $BASH_SOURCE)

if [ ! -d $DIR/../tools/GDart ]; then
    pushd $DIR/../tools/;
     unzip -o GDart.zip -d GDart
    popd;
fi

SPOUT_HOME=$DIR/../tools/GDart/SPouT/sdk/mxbuild/linux-amd64/GRAALVM_ESPRESSO_NATIVE_CE_JAVA11/graalvm-espresso-native-ce-java11-21.2.0/

JAVA_HOME=$(realpath $SPOUT_HOME)

DSE_JAR=$DIR/../tools/GDart/dse/target/dse-0.0.1-SNAPSHOT-jar-with-dependencies.jar

VERIFIER_STUB_CP=$DIR/../tools/GDart/

pushd $VERIFIER_STUB_CP;
    javac tools/aqua/concolic/Verifier.java
popd;
# for kotlin example
#
KOTLIN_HOME=$DIR/../deps/kotlinc/

# for scala example
#
SCALA_HOME=$DIR/../deps/scala3-3.1.0-RC2/
