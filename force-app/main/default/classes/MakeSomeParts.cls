public class MakeSomeParts {
	   public static void genParts(Integer n) {
        List<Vehicle_Part__c> parts = new List<Vehicle_Part__c>();
        for(Integer i = 0; i < n; i++) {
            Vehicle_Part__c part = new Vehicle_Part__c();
       		part.Name = 'Part' + i;
            String prefix;
            Decimal x = Math.random();
            Decimal coinToss = (x * 10).round(System.RoundingMode.FLOOR);
            if(coinToss < 5) {
            	prefix = '1';
        	}
        	else {
            	prefix = '2';
        	}
        	part.Part_Number__c = 'P-000' + i;
        	part.Part_Code__c = prefix + '01' + 2 * i;
            part.Description__c = 'This can be screwed or glued to that car or truck of yours!';
        	parts.add(part);
        }
    insert parts;
    }
}