# GDart Usage Examples

This project contains usage examples for the SPouT and DSE tools that
can be found here:

- [SPouT](https://github.com/tudo-aqua/spout)
- [DSE](https://github.com/tudo-aqua/dse)

SPouT (Symbolic Path Recording During Testing) is a concolic executor for
the [Espresso](https://github.com/oracle/graal/tree/master/espresso) Java virtual machine.

DSE (Dynamic Symbolic Execution) is a generic dynamic symbolic execution engine. 

Please check out the SPouT and DSE repositories for installation and basic usage instructions.

## Examples

The following examples are contained in this projects.

- java11: Demonstrates the analysis of modern Java features with SPouT and DSE (Java Lambda Expression)
- jit: Demonstrates that SPouT profits from JIT (Just in time compilation)
- kotlin: Demonstrates the application of SPouT and DSE to Kotlin programs
- scala:  Demonstrates the application of SPouT to Scala programs
- springboot: Demonstrates that SPouT scales to concolic execution of tests in a SpringBoot web-application through maven

## Before Running Examples
### Compile Components of GDart
To compile and run SPouT, an installation of the GraalVM and the mx build system is required.

We tested compilations with GraalVM 21.1.0, 21.2.0 and 21.3.0-dev.
Checkout the [SPouT README.md] for more instruction on how to install them.
DSE and tools are build using maven. Please make sure that maven is available on your path.

Next, it is required to build all tools.
You could either use the [GDart-SVCOMP](https://github.com/tudo-aqua/gdart-svcomp) repository to setup
and checkout all required paths by:
- Clone `git clone https://github.com/tudo-aqua/gdart-svcomp`
- `cd gdart-svcomp`
- `./compile-all.sh`

if mx and maven are on your path or do it manually:

- Clone and build SPouT (follow instructions in SPouT readme)
- Clone and build DSE (```./compile-jconstraints.sh``` and ```mvn package```)
- Clone and build the [verifier-stub](https://github.com/tudo-aqua/verifier-stub) project (```mvn compile```)

Next, make
- Make ```dse.sh``` and ```spout.sh``` executable (```chmod +x```)
if required.



### Fix paths in ```gdart-examples.sh```
`gdart-examples.sh` contains different locations.
The assumption is that your directory layout is as follows:

shared-parent
-> gdart-examples
-> gdart-svcomp

Otherwise, it is required to modify the paths accordingly to match your local installation.

Next, the `gdart-examples.sh` contains a variable for the KOTLIN\_HOME and SCALA\_HOME.
The KOLTIN\_HOME and SCALA\_HOME are required to run the kotlin and scala examples. Please modify them to valid locations on your system. Eventually, you have to install kotlin and scala first, if you have not done it in the past.

## Run the examples

Once the compilation is complete and the paths in ```gdart-examples.sh``` are adapted to the
paths for kotlin and scala on your machine, it should be possible to go into the example directories
and run the `./run-example.sh` script.
