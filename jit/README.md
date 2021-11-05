
# JIT Example

- compile example
- run with java / spout to observe runtime overhead and JIT

The presented output are traces measured on our machines. The important fact to observe
is the decrease in time during iterations as this is the main feature of JIT in the JVM.

For reproduction, it is not important, if the times are matched exactly as long as the trend stays the same.

# Running Java‚

```
$ java -ea -cp $VERIFIER_STUB_CP:. Main
```

Output:

```
1 (469 ms)
2 (540 ms)
3 (524 ms)
4 (196 ms)
5 (28 ms)
6 (52 ms)
7 (50 ms)
8 (89 ms)
9 (77 ms)
total: 0 (2051 ms)
Exception in thread "main" java.lang.AssertionError
	at Main.main(Main.java:33)
```

# Running SPouT

```
$ [path-to-spoutvm]/bin/java -truffle -ea \
    -cp ../verifier-stub/target/classes/:. Main 
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
1 (5138 ms)
2 (4454 ms)
3 (3019 ms)
4 (2415 ms)
5 (2361 ms)
6 (2410 ms)
7 (2293 ms)
8 (2290 ms)
9 (2241 ms)
total: 0 (28857 ms)
Exception in thread "main" java.lang.AssertionError
	at Main.main(Main.java:33)
======================== END PATH [BEGIN].
[DECLARE] (declare-fun __int_0 () (_ BitVec 32))
[DECISION] (assert (not (!= __int_0 #x00000000))) // branchCount=2, branchId=0
[DECISION] (assert (bvslt #x00000001 (bvadd (bvadd (bvadd (bvadd (bvadd (bvadd (bvadd (bvadd (bvadd __int_0 #x00000001) #x00000001) #x00000001) #x00000001) #x00000001) #x00000001) #x00000001) #x00000001) #x00000001))) // branchCount=2, branchId=0
[ERROR] java/lang/AssertionError
======================== END PATH [END].
[ENDOFTRACE]
```

