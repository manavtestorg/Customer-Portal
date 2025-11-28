public with sharing class MathUtils {
    // Intentionally incorrect method (bug)
    public static Integer addNumbers(Integer a, Integer b) {
        // BUG: should be (a + b) but returns (a - b)
        return a - b;
    }

    public static Integer divideNumbers(Integer a, Integer b) {
        // BUG: no check for divide-by-zero
        return a / b;
    }
}