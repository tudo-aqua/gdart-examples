# Scala Example

## Compilation

```
~/workspace/scala3-3.1.0-RC2/bin/scalac -cp ../verifier-stub/target/classes/ Main.scala
```

## Concolic Execution

```
JAVACMD=./java.sh ~/workspace/scala3-3.1.0-RC2/bin/scala -cp ../verifier-stub/target/classes/ Hello
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


Setting concolic values can be done in ```./java.sh```
