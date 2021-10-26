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
- scala:  Demonstrates the application of SPouT and DSE to Scala programs
- springboot: Demonstrates that SPouT scales to concolic execution of tests in a SpringBoot web-application through maven

## Before Running Examples

- Clone and build SPouT (follow instructions in SPouT readme)
- Clone and build DSE (```./compile-jconstraints.sh``` and ```mvn package```)
- Clone and build the [verifier-stub](https://github.com/tudo-aqua/verifier-stub) project (```mvn compile```)

- Fix paths in ```gdart-examples.sh```
- Make ```dse.sh``` and ```spout.sh``` executable (```chmod +x```)

