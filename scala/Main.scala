
import tools.aqua.concolic.Verifier;

object Hello {
    def main(args: Array[String]) = {
        println("Hello, world")
        val x = Verifier.nondetInt()
        if (x > 0) {
          assert(false)
        }
    }
}
