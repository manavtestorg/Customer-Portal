@IsTest
private class MathUtilsTest {

    @IsTest
    static void testAdditionSuccess() {
        // Expected correct behavior (test will FAIL because the class has a bug)
        Integer result = MathUtils.addNumbers(2, 3);
        System.assertEquals(5, result, 'Addition should equal 5'); 
    }

    @IsTest
    static void testAdditionFailureCase() {
        // This test also fails (2 - 3 = -1)
        Integer result = MathUtils.addNumbers(10, 10);
        System.assertEquals(20, result, 'Addition should equal 20');
    }

    @IsTest
    static void testDivideByZero() {
        // This test causes an unhandled exception → test FAIL
        try {
            MathUtils.divideNumbers(10, 0);
            System.assert(false, 'Expected division by zero exception');
        } catch (Exception e) {
            System.assert(e.getMessage().contains(''), 'Exception expected');
        }
    }

    @IsTest
    static void testDivideSuccess() {
        // This one will PASS
        Integer result = MathUtils.divideNumbers(10, 2);
        System.assertEquals(5, result);
    }
}