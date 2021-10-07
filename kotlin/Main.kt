package org.kotlinlang.play         

import tools.aqua.concolic.Verifier;

fun main() {                        
    println("Hello, World!")
    val x = Verifier.nondetInt()
    if (x > 0) {
        assert(false)
    }
}
