public class OrderCalculationService {
    
    // Returns total price = price * quantity
    public static Decimal calculateTotal(Decimal price, Integer quantity) {
        if (price == null || quantity == null) {
            throw new AuraHandledException('Price or quantity cannot be null.');
        }
        return price * quantity;
    }

    // Returns discount percentage; fails if discount > 50%
    public static Decimal applyDiscount(Decimal amount, Decimal discountPercent) {
        if (discountPercent > 50) {
            throw new AuraHandledException('Discount cannot exceed 50%.');
        }
        return amount - (amount * (discountPercent / 100));
    }
}