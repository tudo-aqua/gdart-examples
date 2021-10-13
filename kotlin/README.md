# Kotlin Example


- Download Kotlin, e.g., https://github.com/JetBrains/kotlin/releases/tag/v1.5.31

## Compile 

```
$ [path-to-kotlin]/bin/kotlinc -cp ../verifier-stub/target/classes/ Main.kt 
export JAVA_HOME=[path-to-spoutvm]
```

## Concolic Execution

```
$ [path-to-kotlin]/bin/kotlin -J"-truffle" -J"-ea" -cp ../verifier-stub/target/classes/:. MainKt
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

With concolic values:


```
$ [path-to-kotlin]/bin/kotlin -J"-truffle" -J"-ea" -cp ../verifier-stub/target/classes/:. -Dconcolic.ints=1 MainKt

```

Output:


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

```
 ../dse.sh -Ddse.executor=./executor.sh -Ddse.dp=multi "-Ddse.executor.args=-cp ../verifier-stub/target/classes/:. MainKt" 
 ```

Output:


```
...


./executor.sh          -cp ../verifier-stub/target/classes/:. MainKt
Decision{condition=('__int_0' bvsle 0), branches=2, branchId=1, assumption=false}
OK: 
./executor.sh     -Dconcolic.ints=2     -cp ../verifier-stub/target/classes/:. MainKt
Decision{condition=!('__int_0' bvsle 0), branches=2, branchId=0, assumption=false}
ERROR: java/lang/AssertionError

+ 0 : !('__int_0' bvsle 0)
  + ERROR[complete path:true] . __int_0:=2 . java/lang/AssertionError
+ 1 : ('__int_0' bvsle 0)
  + OK[complete path:true] . 

[END OF OUTPUT]
```


