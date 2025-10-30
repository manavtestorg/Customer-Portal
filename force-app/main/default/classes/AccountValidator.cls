/**
 * @description Account validation logic for customer profile updates
 * @author Demo Developer
 * @date 2025-10-30
 * 
 * User Story: Implement Customer Account Validation Logic
 * Commit 2: Fixed bugs and added duplicate phone validation
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
            // Validate website format
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
            
            // FIXED: Added duplicate phone validation
            if (String.isNotBlank(acc.Phone)) {
                if (hasDuplicatePhone(acc.Phone, acc.Id)) {
                    acc.Phone.addError('This phone number is already associated with another account.');
                    isValid = false;
                }
            }
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
    
    /**
     * @description Checks if phone number already exists in another account
     * @param phone Phone number to check
     * @param accountId Current account ID (null for new records)
     * @return Boolean indicating if duplicate exists
     */
    private static Boolean hasDuplicatePhone(String phone, Id accountId) {
        List<Account> existingAccounts;
        
        if (accountId != null) {
            existingAccounts = [
                SELECT Id 
                FROM Account 
                WHERE Phone = :phone 
                AND Id != :accountId 
                LIMIT 1
            ];
        } else {
            existingAccounts = [
                SELECT Id 
                FROM Account 
                WHERE Phone = :phone 
                LIMIT 1
            ];
        }
        
        return !existingAccounts.isEmpty();
    }
}