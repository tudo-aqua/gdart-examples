# Scala Example

To run the scala example, just execute the `./run-example.sh` script.
The following guide explains the involved steps in more detail.

## Setup Paths

The scripts assume that various environement variables are set.
Most important for the scala example is the SCALA_HOME variable.

You might set them by sourcing ../gdart-examples.sh:
```
source ../gdart-examples.sh
```

## Compilation

```
$SCALA_HOME/bin/scalac -cp ../verifier-stub/target/classes/ Main.scala
```

## Concolic Execution

```
JAVACMD=./java.sh
$SCALA_HOME/scala3-3.1.0-RC2/bin/scala -cp ../verifier-stub/target/classes/ Hello
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
Hello, world
======================== END PATH [BEGIN].
[DECLARE] (declare-fun __int_0 () (_ BitVec 32))
[DECISION] (assert (bvsge #x00000000 __int_0)) // branchCount=2, branchId=1
======================== END PATH [END].
[ENDOFTRACE]
```


Setting concolic values can be done in by modifying the JAVA_OPTS environment variable.
We present this in the second step, setting the first random int to 1.

```
export JAVA_OPTS="-Dconcolic.ints=1"
$SCALA_HOME/bin/scala -cp $VERIFIER_STUB_CP Hello
```

This generates the output:
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
Hello, world
java.lang.AssertionError: assertion failed
    at scala.runtime.Scala3RunTime$.assertFailed(Scala3RunTime.scala:11)
    at Hello$.main(Main.scala:9)
    at Hello.main(Main.scala)
    at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
    at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
    at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
    at java.base/java.lang.reflect.Method.invoke(Method.java:566)
    at dotty.tools.runner.RichClassLoader$.run$extension$$anonfun$1(ScalaClassLoader.scala:95)
    at dotty.tools.runner.RichClassLoader$.asContext$extension(ScalaClassLoader.scala:30)
    at dotty.tools.runner.RichClassLoader$.run$extension(ScalaClassLoader.scala:95)
    at dotty.tools.runner.CommonRunner.run(ObjectRunner.scala:23)
    at dotty.tools.runner.CommonRunner.run$(ObjectRunner.scala:13)
    at dotty.tools.runner.ObjectRunner$.run(ObjectRunner.scala:48)
    at dotty.tools.runner.CommonRunner.runAndCatch(ObjectRunner.scala:30)
    at dotty.tools.runner.CommonRunner.runAndCatch$(ObjectRunner.scala:13)
    at dotty.tools.runner.ObjectRunner$.runAndCatch(ObjectRunner.scala:48)
    at dotty.tools.MainGenericRunner$.run$1(MainGenericRunner.scala:149)
    at dotty.tools.MainGenericRunner$.main(MainGenericRunner.scala:175)
    at dotty.tools.MainGenericRunner.main(MainGenericRunner.scala)
======================== END PATH [BEGIN].
[DECLARE] (declare-fun __int_0 () (_ BitVec 32))
[DECISION] (assert (bvslt #x00000000 __int_0)) // branchCount=2, branchId=0
======================== END PATH [END].
[ENDOFTRACE]

```

Note: While the output demonstrate the effect ot the seeded value, the assertion check is differently implemented
in scala than in Java. SPouT does not record the Error invocation in Scala at the moment in the path description.


In the last step, we demonstrate the tree exploration using the DSE component.
Invoking DSE with the following command:
```
../dse.sh -Ddse.executor=./executor.sh -Ddse.dp=multi "-Ddse.executor.args=-cp $VERIFIER_STUB_CP Hello"
```

leads to the following explored tree:
```
./executor.sh          -cp ../../tools/GDart/ Hello
Decision{condition=(0 bvsge '__int_0'), branches=2, branchId=1, assumption=false}
OK:
./executor.sh     -Dconcolic.ints=2     -cp ../../tools/GDart/ Hello
Decision{condition=(0 bvslt '__int_0'), branches=2, branchId=0, assumption=false}
OK:

+ 0 : (0 bvslt '__int_0')
  + OK[complete path:true] . __int_0:=2
+ 1 : (0 bvsge '__int_0')
  + OK[complete path:true] .

[END OF OUTPUT]

```

Note: As SPouT does not describe the errors in Scala correctly yet,
they are not refelected correctly in the tree result at the moment.
