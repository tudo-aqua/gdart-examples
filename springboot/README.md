# SpringBoot Example

## Preparation and Compilation

```
$ git clone https://github.com/spring-projects/spring-petclinic.git
$ cd spring-petclinic
$ cp ../pom.xml .
$ cp ../VisitControllerTests.java src/test/java/org/springframework/samples/petclinic/owner/
$ mvn clean compile
```

## Concolic Execution

```
$ export JAVA_HOME=[path-to-graalvm]
$ mvn -Dtest=VisitControllerTests.java#testInitNewVisitForm -DargLine="-truffle -Dconcolic.ints=1" test

```

Primary Output:

```
find [WARNING] Corrupted STDOUT by directly writing to native stream in forked JVM 1. See FAQ web page and the dump file .../spring-petclinic/target/surefire-reports/...-jvmRun1.dumpstream
```

In Dumpstream:

```
$ less target/surefire-reports/...-jvmRun1.dumpstream
```

Log:

```
...
Corrupted STDOUT by directly writing to native stream in forked JVM 1. Stream '[DECISION] (assert (= #x00000001 __int_0)) // branchCount=2, branchId=0'.
...
```
