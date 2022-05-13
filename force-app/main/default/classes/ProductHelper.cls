public class ProductHelper {
    public static void RequireDescription (List<Product2> prods) {
        for (Product2 p : prods) {
            if (p.Description == null) {
                p.addError('Description cannot be empty.');
            }
        }	
    }
    
    public static void NewInspectionOrder (List<Product2> prods) {
        
    }
}