public class PutInProducts {
	 public static void genProduct(Integer n) {
         	 List<Product2> autos = new List<Product2>();
		     for(Integer i = 0; i < n; i++) {
             Product2 auto = new Product2();
             Decimal x = Math.random();
             Decimal coinToss = (x * 10).round(System.RoundingMode.FLOOR);
        	 String fam;
        	 if(coinToss <= 5) {
            	fam = 'Light Duty';
        	}
        	else {
            	fam = 'Heavy Duty';
        	}
            auto.Name = 'product' + i;
            auto.ProductCode = 'SM69-' + 3 * i;
            auto.Family = fam;
            auto.IsActive = true;
            auto.Description = 'This is what you call real transportation!';
            autos.add(auto);    
        }
      insert autos;        
    }
}