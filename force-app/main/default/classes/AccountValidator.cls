/**
 * @description Account validation logic for customer profile updates
 * @author Demo Developer
 * @date 2025-10-30
 * 
 * User Story: Implement Customer Account Validation Logic
 * Commit 2: Fixed duplicate phone validation with proper bulkification
 * 
 * Changes in this commit:
 * - Implemented duplicate phone number validation
 * - Fixed bulkification issues (single SOQL query)
 * - Added proper handling for account updates
 * - Improved website validation
 */
public class AccountValidator {
    
    /**
     * @description Validates account data before save
     * @param accounts List of accounts to validate
     * @return Boolean indicating if validation passed
     */
    public static Boolean validateAccounts(List<Account> accounts) {
        if (accounts == null || accounts.isEmpty()) {
            return true;
        }
        
        Boolean isValid = true;
        
        // Collect all phone numbers for bulk duplicate check
        Map<String, Account> phoneToAccountMap = new Map<String, Account>();
        Set<Id> accountIds = new Set<Id>();
        
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
            
            // Collect phone numbers for bulk duplicate check
            if (String.isNotBlank(acc.Phone)) {
                phoneToAccountMap.put(acc.Phone, acc);
                if (acc.Id != null) {
                    accountIds.add(acc.Id);
                }
            }
        }
        
        // Perform bulk duplicate phone check (single SOQL query)
        if (!phoneToAccountMap.isEmpty()) {
            try {
                List<Account> existingAccounts;
                
                if (!accountIds.isEmpty()) {
                    // For updates: exclude current account IDs
                    existingAccounts = [
                        SELECT Id, Phone, Name
                        FROM Account 
                        WHERE Phone IN :phoneToAccountMap.keySet() 
                        AND Id NOT IN :accountIds
                        LIMIT 50000
                    ];
                } else {
                    // For new records: check all
                    existingAccounts = [
                        SELECT Id, Phone, Name
                        FROM Account 
                        WHERE Phone IN :phoneToAccountMap.keySet()
                        LIMIT 50000
                    ];
                }
                
                // Check for duplicates and add errors
                for (Account existingAcc : existingAccounts) {
                    if (phoneToAccountMap.containsKey(existingAcc.Phone)) {
                        Account accToUpdate = phoneToAccountMap.get(existingAcc.Phone);
                        accToUpdate.Phone.addError(
                            'This phone number is already associated with another account: ' + 
                            existingAcc.Name + '. Please use a unique phone number.'
                        );
                        isValid = false;
                    }
                }
            } catch (Exception e) {
                // Handle any unexpected errors during duplicate check
                System.debug('Error during duplicate phone validation: ' + e.getMessage());
                throw new ValidationException('Unable to validate phone numbers. Please contact your administrator.');
            }
        }
        
        return isValid;
    }
    
    /**
     * @description Validates website format using pattern matching
     * @param website Website URL to validate
     * @return Boolean indicating if website is valid
     */
    private static Boolean isValidWebsite(String website) {
        if (String.isBlank(website)) {
            return true;
        }
        
        // Enhanced validation - must contain a dot and no spaces
        // Future enhancement: Use regex for more robust validation
        return website.contains('.') && !website.contains(' ');
    }
    
    /**
     * @description Custom exception for validation errors
     */
    public class ValidationException extends Exception {}
}