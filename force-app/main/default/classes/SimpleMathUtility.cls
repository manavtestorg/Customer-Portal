public class SimpleMathUtility {

    public static Integer addNumbers(Integer a, Integer b) {
        if (a == null || b == null) {
            throw new AuraHandledException('Inputs cannot be null');
        }
        return a + b;
    }

    public static Decimal divideNumbers(Decimal a, Decimal b) {
        if (a == null || b == null) {
            throw new AuraHandledException('Inputs cannot be null');
        }

        if (b == 0) {
            throw new AuraHandledException('Cannot divide by zero');
        }

        return a / b;
    }

    public static Decimal squareRoot(Decimal x) {
        if (x == null) {
            throw new AuraHandledException('Input cannot be null');
        }

        if (x < 0) {
            throw new AuraHandledException('Cannot take square root of a negative number');
        }

        return Math.sqrt(x);
    }
}