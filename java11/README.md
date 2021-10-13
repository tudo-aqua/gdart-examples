# JAVA 11 Example

## Compilation

```
$ javac -cp ../verifier-stub/target/classes/ Main.java 
```

## Concolic Execution

```
$ [path-to-spoutvm]/bin/java -truffle -ea -cp ../verifier-stub/target/classes/:. Main 
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
======================== END PATH [BEGIN].
[DECLARE] (declare-fun __int_0 () (_ BitVec 32))
[DECISION] (assert (bvsge #x00000064 __int_0)) // branchCount=2, branchId=1
======================== END PATH [END].
[ENDOFTRACE]
```

```
$ [path-to-spoutvm]/bin/java -truffle -ea -cp ../verifier-stub/target/classes/:. -Dconcolic.ints=101 Main 
```

Output:

```
======================== START PATH [BEGIN].
Seeded Bool Values: []
Seeded Byte Values: []
Seeded Char Values: []
Seeded Short Values: []
Seeded Int Values: [101]
Seeded Long Values: []
Seeded Float Values: []
Seeded Double Values: []
Seeded String Values: []
======================== START PATH [END].
Exception in thread "main" java.lang.AssertionError
	at Main.lambda$main$0(Main.java:13)
	at java.base/java.util.ArrayList.forEach(ArrayList.java:1541)
	at Main.main(Main.java:13)
======================== END PATH [BEGIN].
[DECLARE] (declare-fun __int_0 () (_ BitVec 32))
[DECISION] (assert (bvslt #x00000064 __int_0)) // branchCount=2, branchId=0
[ERROR] java/lang/AssertionError
======================== END PATH [END].
[ENDOFTRACE]
```

## Concolic Analysis

```
$ ../dse.sh -Ddse.executor=./executor.sh -Ddse.dp=multi \
    "-Ddse.executor.args=-cp ../verifier-stub/target/classes/:. Main" 
```

Output:

```
...

../executor.sh          -cp ../verifier-stub/target/classes/:. Main
Decision{condition=(100 bvsge '__int_0'), branches=2, branchId=1, assumption=false}
OK: 
../executor.sh     -Dconcolic.ints=101     -cp ../verifier-stub/target/classes/:. Main
Decision{condition=(100 bvslt '__int_0'), branches=2, branchId=0, assumption=false}
ERROR: java/lang/AssertionError

+ 0 : (100 bvslt '__int_0')
  + ERROR[complete path:true] . __int_0:=101 . java/lang/AssertionError
+ 1 : (100 bvsge '__int_0')
  + OK[complete path:true] . 

[END OF OUTPUT]

```
