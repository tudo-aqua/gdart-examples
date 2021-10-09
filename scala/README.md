~/workspace/scala3-3.1.0-RC2/bin/scalac -cp ../verifier-stub/target/classes/ Main.scala

echo "~/workspace/graal/sdk/mxbuild/linux-amd64/GRAALVM_ESPRESSO_NATIVE_CE_JAVA11/graalvm-espresso-native-ce-java11-21.2.0/bin/java -truffle \$@" > ./java.sh
chmod +x java.sh

JAVACMD=./java.sh ~/workspace/scala3-3.1.0-RC2/bin/scala -cp ../verifier-stub/target/classes/ Hello

