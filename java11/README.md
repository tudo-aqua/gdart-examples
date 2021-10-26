# JAVA 11 Example

## Compilation

```
$ source ../gdart-examples.sh
$ javac -cp $VERIFIER_STUB_CP Main.java 
```

## Concolic Execution

We record symbolic constraints during teh execution of ```Main``` as follows

```
$ source ../gdart-examples.sh
$ ../spout.sh -cp $VERIFIER_STUB_CP:. Main 
```

SPouT will produce the following output that contains a symbolic trace:

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

We can set a concrete value for variable ```__int_0``` through ```-Dconcolic.ints=101``` as shown below:

```
$ source ../gdart-examples.sh
$ ./spout.sh -cp $VERIFIER_STUB_CP:. -Dconcolic.ints=101 Main 
```

This will drive execution down another path, leading to the following output:

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

We use DSE to compute complete symbolic execution trees on the basis of 
paths recorded by spout:

```
$ chmod +x executor.sh
$ source ../gdart-examples.sh
$ ../dse.sh -Ddse.executor=./executor.sh -Ddse.dp=multi \
    "-Ddse.executor.args=-cp $VERIFIER_STUB_CP:. Main" 
```

The analysis will execute the two paths shown above and produce the following output:


```
...

../executor.sh          -cp ../verifier-stub/target/classes/:. Main
Decision{condition=(100 bvsge '__int_0'), branches=2, branchId=1, assumption=false}
OK: 
../executor.sh     -Dconcolic.ints=101     -cp .../verifier-stub/target/classes/:. Main
Decision{condition=(100 bvslt '__int_0'), branches=2, branchId=0, assumption=false}
ERROR: java/lang/AssertionError

+ 0 : (100 bvslt '__int_0')
  + ERROR[complete path:true] . __int_0:=101 . java/lang/AssertionError
+ 1 : (100 bvsge '__int_0')
  + OK[complete path:true] . 

[END OF OUTPUT]

```
