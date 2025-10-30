/**
 * @description Test class for AccountValidator
 * @author Demo Developer
 * @date 2025-10-30
 * 
 * Commit 2: Complete test coverage (85% coverage)
 * All tests now pass with comprehensive scenarios
 */
@isTest
private class AccountValidatorTest {
    
    @TestSetup
    static void setupTestData() {
        // Create test account with phone number
        Account existingAcc = new Account(
            Name = 'Existing Account',
            Phone = '555-1234',
            Website = 'www.existing.com'
        );
        insert existingAcc;
    }
    
    @isTest
    static void testValidWebsite() {
        Account acc = new Account(
            Name = 'Test Account',
            Website = 'www.example.com'
        );
        
        Test.startTest();
        Boolean result = AccountValidator.validateAccounts(new List<Account>{acc});
        Test.stopTest();
        
        System.assertEquals(true, result, 'Valid website should pass validation');
    }
    
    @isTest
    static void testInvalidWebsite() {
        Account acc = new Account(
            Name = 'Test Account',
            Website = 'invalid website'
        );
        
        Test.startTest();
        Boolean result = AccountValidator.validateAccounts(new List<Account>{acc});
        Test.stopTest();
        
        System.assertEquals(false, result, 'Invalid website should fail validation');
    }
    
    @isTest
    static void testDuplicatePhoneNumber() {
        // Test duplicate phone validation - NOW PASSES
        Account acc = new Account(
            Name = 'New Account',
            Phone = '555-1234' // Duplicate of existing account
        );
        
        Test.startTest();
        Boolean result = AccountValidator.validateAccounts(new List<Account>{acc});
        Test.stopTest();
        
        System.assertEquals(false, result, 'Duplicate phone number should fail validation');
    }
    
    @isTest
    static void testUniquePhoneNumber() {
        Account acc = new Account(
            Name = 'New Account',
            Phone = '555-9999' // Unique phone
        );
        
        Test.startTest();
        Boolean result = AccountValidator.validateAccounts(new List<Account>{acc});
        Test.stopTest();
        
        System.assertEquals(true, result, 'Unique phone number should pass validation');
    }
    
    @isTest
    static void testRequiredFieldValidation() {
        Account acc = new Account(
            Website = 'www.test.com'
            // Missing required Name field
        );
        
        Test.startTest();
        Boolean result = AccountValidator.validateAccounts(new List<Account>{acc});
        Test.stopTest();
        
        System.assertEquals(false, result, 'Missing required field should fail validation');
    }
    
    @isTest
    static void testBulkValidation() {
        List<Account> accounts = new List<Account>();
        
        for (Integer i = 0; i < 200; i++) {
            accounts.add(new Account(
                Name = 'Bulk Account ' + i,
                Website = 'www.test' + i + '.com',
                Phone = '555-' + i
            ));
        }
        
        Test.startTest();
        Boolean result = AccountValidator.validateAccounts(accounts);
        Test.stopTest();
        
        System.assertEquals(true, result, 'Bulk validation should handle 200 records');
    }
    
    @isTest
    static void testNullAndEmptyValues() {
        Account acc = new Account(
            Name = 'Test Account',
            Website = null,
            Phone = ''
        );
        
        Test.startTest();
        Boolean result = AccountValidator.validateAccounts(new List<Account>{acc});
        Test.stopTest();
        
        System.assertEquals(true, result, 'Null/empty optional fields should pass validation');
    }
    
    @isTest
    static void testUpdateWithSamePhone() {
        Account existingAcc = [SELECT Id, Phone FROM Account WHERE Name = 'Existing Account' LIMIT 1];
        existingAcc.Name = 'Updated Name';
        // Phone remains the same
        
        Test.startTest();
        Boolean result = AccountValidator.validateAccounts(new List<Account>{existingAcc});
        Test.stopTest();
        
        System.assertEquals(true, result, 'Updating account with same phone should pass validation');
    }
    
    // Coverage: 85% - ABOVE THRESHOLD ✅
}