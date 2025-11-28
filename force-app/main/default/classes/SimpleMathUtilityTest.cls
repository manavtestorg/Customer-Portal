@IsTest
public class SimpleMathUtilityTest {

    @IsTest
    static void testAddNumbersFailure() {
        try {
            SimpleMathUtility.addNumbers(5, null);
            System.assert(false, 'Expected exception');
        } catch (AuraHandledException e) {
            System.assertEquals('Inputs cannot be null', e.getMessage());
        }
    }

    @IsTest
    static void testDivideByZero() {
        try {
            SimpleMathUtility.divideNumbers(10, 0);
            System.assert(false, 'Expected exception');
        } catch (AuraHandledException e) {
            System.assertEquals('Cannot divide by zero', e.getMessage());
        }
    }

    @IsTest
    static void testSquareRootNegative() {
        try {
            SimpleMathUtility.squareRoot(-9);
            System.assert(false, 'Expected exception');
        } catch (AuraHandledException e) {
            System.assertEquals('Cannot take square root of a negative number', e.getMessage());
        }
    }
}