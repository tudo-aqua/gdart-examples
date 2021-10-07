import tools.aqua.concolic.Verifier;
import java.util.ArrayList;

public class Main {

  public static void main(String[] args) {
    int i = Verifier.nondetInt();
    ArrayList<Integer> numbers = new ArrayList<Integer>();
    numbers.add(5);
    numbers.add(9);
    numbers.add(i);
    numbers.add(1);
    numbers.forEach( (n) -> { if (n > 100) assert false; } );
  }

}
