/**
 * @description Account validation logic for customer profile updates
 * @author Demo Developer
 * @date 2025-10-30
 * 
 * User Story: Implement Customer Account Validation Logic
 * Commit 1: Initial implementation (has bugs and incomplete logic)
 */
public class AccountValidator {
    
    /**
     * @description Validates account data before save
     * @param accounts List of accounts to validate
     * @return Boolean indicating if validation passed
     */
    public static Boolean validateAccounts(List<Account> accounts) {
        Boolean isValid = true;
        
        for (Account acc : accounts) {
            // Validate website format (simulating email validation)
            if (String.isNotBlank(acc.Website)) {
                if (!isValidWebsite(acc.Website)) {
                    acc.Website.addError('Invalid website format. Please enter a valid URL (e.g., www.example.com).');
                    isValid = false;
                }
            }
            
            // Validate required fields
            if (String.isBlank(acc.Name)) {
                acc.Name.addError('Account Name is required.');
                isValid = false;
            }
            
            // BUG: Duplicate phone validation is missing proper implementation
            // This will cause test failures
        }
        
        return isValid;
    }
    
    /**
     * @description Validates website format using basic pattern matching
     * @param website Website URL to validate
     * @return Boolean indicating if website is valid
     */
    private static Boolean isValidWebsite(String website) {
        // Simple validation - must contain a dot and no spaces
        return website.contains('.') && !website.contains(' ');
    }
    
    // Missing: Duplicate phone number validation method
    // Missing: Comprehensive error handling
}