# SpringBoot Example
The SpringBoot example demonstrates, that it is possible to integrate
SPouT into unit tests and run it along with normal JUnit test generating symbolic paths.

We demonstrate this by showing that the SPouT framework puts out symbolic annotations on the
standard output stream in the `run-example.sh` script.

As SPouT does not fit the logging infrastructure of SpringBoot at the moment,
the output is encapsulated in IllegalArguemntExceptions to the Std stream.
Anyhow, the example presents that the information is written to standard out in the JVM and SPouT can be invoked from within Maven.


## Preparation and Compilation
The following step prepare the project in a normal machine.
```
$ git clone https://github.com/spring-projects/spring-petclinic.git
$ cd spring-petclinic
$ cp ../pom.xml .
$ cp ../VisitControllerTests.java src/test/java/org/springframework/samples/petclinic/owner/
$ mvn clean compile
```

## Concolic Execution

The following command invokes the unit test of interest:
```
$ export JAVA_HOME=[path-to-graalvm]
$ mvn -Dtest=VisitControllerTests.java#testInitNewVisitForm -DargLine="-truffle -Dconcolic.ints=1" test

```

We expect the following warning in the primary output:

```
find [WARNING] Corrupted STDOUT by directly writing to native stream in forked JVM 1. See FAQ web page and the dump file .../spring-petclinic/target/surefire-reports/...-jvmRun1.dumpstream
```

The dumpstream contains more information and is accessed by the following command replacing the ... with the full name:
```
...
$ less target/surefire-reports/...-jvmRun1.dumpstream
...

```

In the log, the following lines will be contained:

```
...
Corrupted STDOUT by directly writing to native stream in forked JVM 1. Stream '[DECISION] (assert (= #x00000001 __int_0)) // branchCount=2, branchId=0'.
...
```
