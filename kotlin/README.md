# Kotlin Example

The Kotlin example demonstrates the exploration of a Kotlin code snippet.
Run the `./run-example.sh` script to execute the example. The remainder of the README.md file explains the steps
in the script.

## Setup Kotlin

First, we need to install Kotlin.

If you want to explore more Kotlin programs on your system, it might be useful to install Kotlin and add it to the path (e.g., you will get it here: https://github.com/JetBrains/kotlin/releases/tag/v1.5.31)

For running the example, we added a zipped Kotlin compiler to the artifact.
It contains a Kotlin compiler and will be extracted and setup for the example as part of the script.
Once the zip is extracted,
KOTLIN_HOME and SPOUT_HOME are set by sourcing gdart-examples.sh with:

```
source ../gdart-example.sh
```

## Compile 

```
$KOTLIN_HOME/bin/kotlinc -cp $VERIFIER_STUB_CP Main.kt
export JAVA_HOME=$SPOUT_HOME
```

## Concolic Execution

We execute the Kotlin program with SPouT without setting any concrete values for the
concrete variables.
```
$KOTLIN_HOME/bin/kotlin -J"-truffle" -J"-ea" -cp $VERIFIER_STUB_CP:. MainKt
```

Output:

```
======================== START PATH [BEGIN].
Seeded Bool Values: []
Seeded Byte Values: []
Seeded Char Values: []
Seeded Short Values: []
Seeded Int Values: []
Seeded Long Values: []
Seeded Float Values: []
Seeded Double Values: []
Seeded String Values: []
======================== START PATH [END].
Hello, World!
======================== END PATH [BEGIN].
[DECLARE] (declare-fun __int_0 () (_ BitVec 32))
[DECISION] (assert (bvsle __int_0 #x00000000)) // branchCount=2, branchId=1
======================== END PATH [END].
[ENDOFTRACE]
```

Then the script reruns the same command setting the first symbolic int to 1:


```
$KOTLIN_HOME/bin/kotlin -J"-truffle" -J"-ea" -cp $VERIFIER_STUB_CP:. -Dconcolic.ints=1 MainKt

```

This will trigger an assertion in the output:


```
======================== START PATH [BEGIN].
Seeded Bool Values: []
Seeded Byte Values: []
Seeded Char Values: []
Seeded Short Values: []
Seeded Int Values: [1]
Seeded Long Values: []
Seeded Float Values: []
Seeded Double Values: []
Seeded String Values: []
======================== START PATH [END].
Hello, World!
Exception in thread "main" java.lang.AssertionError: Assertion failed
	at MainKt.main(Main.kt:7)
	at MainKt.main(Main.kt)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.base/java.lang.reflect.Method.invoke(Method.java:566)
	at org.jetbrains.kotlin.runner.AbstractRunner.run(runners.kt:64)
	at org.jetbrains.kotlin.runner.Main.run(Main.kt:176)
	at org.jetbrains.kotlin.runner.Main.main(Main.kt:186)
======================== END PATH [BEGIN].
[DECLARE] (declare-fun __int_0 () (_ BitVec 32))
[DECISION] (assert (not (bvsle __int_0 #x00000000))) // branchCount=2, branchId=0
[ERROR] java/lang/AssertionError
======================== END PATH [END].
[ENDOFTRACE]
```

## Concolic Analysis
The concolic analysis explores the complete symbolic branching tree in the program.
It is invoked using the following command:
```
 ../dse.sh -Ddse.executor=./executor.sh -Ddse.dp=multi "-Ddse.executor.args=-cp $VERIFIER_STUB_CP:. MainKt"
 ```

The expected output is:


```
...


./executor.sh          -cp ../../tools/GDart/:. MainKt
Decision{condition=('__int_0' bvsle 0), branches=2, branchId=1, assumption=false}
OK: 
./executor.sh     -Dconcolic.ints=2     -cp ../../tools/GDart/:. MainKt
Decision{condition=!('__int_0' bvsle 0), branches=2, branchId=0, assumption=false}
ERROR: java/lang/AssertionError

+ 0 : !('__int_0' bvsle 0)
  + ERROR[complete path:true] . __int_0:=2 . java/lang/AssertionError
+ 1 : ('__int_0' bvsle 0)
  + OK[complete path:true] . 

[END OF OUTPUT]
```
In the Kotlin example is only one branching condition guarding an assertion error. This
error get triggered once and skipped on the other branch.

