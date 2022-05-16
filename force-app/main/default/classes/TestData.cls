@isTest
public class TestData {
//generates n Smythes
    public static void genCtact(Integer n) {
        List<Contact> ctc = new List<Contact>();
        for(Integer i = 0; i < n; i++) {
            Contact c = new Contact();
            String nm = 'Smythe';
            c.LastName = nm + i;
            ctc.add(c);
        }
        insert ctc;
    }
//generates n sales appointments on random dates in the middle of May 2022
    public static void genAppt(Integer n) {
        List<Appointment__c> appmnt = new List<Appointment__c>();
        genCtact(n);
        List<Contact> ct = [SELECT ID FROM Contact];
        for(Integer i = 0; i < n; i++) {
            Decimal x = Math.random();
            Decimal y = (x * n).round(System.RoundingMode.FLOOR);
            Integer j = (Integer)y;
            Decimal randDay = (x * 14).round(System.RoundingMode.FLOOR) + 10;
       	    Decimal randHr = (x * 7).round(System.RoundingMode.FLOOR) + 9;
            Decimal randMn = (x * 59).round(System.RoundingMode.FLOOR);
            String amPM;
            if(randHr -12 < 0) {
               amPM = 'AM';
            }
            else {
               amPM = 'PM';
            }
            if(randHr > 12) {
                randHr = randHr - 12;
            }
            String dt = '5/' + randDay + '/2022,' + randHr + ':' + randMn + ' ' +amPM;
            Datetime aptTime = Datetime.Parse(dt);
            Appointment__c ap = new Appointment__c();
            ap.Name = 'Appointment' + i;
            ap.Contact__c = ct[j].Id;
			ap.Time__c = aptTime;
			ap.Type__c = 'Sales';
            ap.Description__c = 'This is appointment # ' + i;
            ap.Salesperson__c = 'Sally Salesperson';
			appmnt.add(ap);            
        }
        insert appmnt;
    }
//generates n car parts
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
//generates n products, randomly assigned as light or heavy duty

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