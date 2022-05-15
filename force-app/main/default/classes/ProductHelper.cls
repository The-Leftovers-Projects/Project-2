public class ProductHelper {
    public static void requireDescription (List<Product2> prods) {
        for (Product2 p : prods) {
            if (p.Description == null) {
                p.addError('Description cannot be empty.');
            }
        }	
    }
    
    public static void newInspectionOrder (List<Product2> prods) {
        Inspection_Order__c i = new Inspection_Order__c();

        for (Product2 p : prods) {
            i.Name = p.Name + ' Order';
        }
    }
}