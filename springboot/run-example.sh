#!/bin/bash

source ../gdart-examples.sh

git clone https://github.com/spring-projects/spring-petclinic.git
pushd spring-petclinic;
    cp ../pom.xml .
    cp ../VisitControllerTests.java src/test/java/org/springframework/samples/petclinic/owner/
    mvn  clean compile

    printf "\n\n Compilation done -- Run demonstration test \n\n"
    mvn -Dtest=VisitControllerTests.java#testInitNewVisitForm -DargLine="-truffle -Dconcolic.ints=1" test
    printf "\n\n Find results in the log \n\n"
    cat target/surefire-reports/*-jvmRun1.dumpstream |grep -A 10 -B 10 DECISION
popd;

