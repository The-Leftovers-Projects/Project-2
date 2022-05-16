public class CreateApptData {
    public static void genCtact(Integer n, String name) {
        List<Contact> ctc = new List<Contact>();
        for(Integer i = 0; i < n; i++) {
            Contact c = new Contact();
            String nm = name;
            c.LastName = nm + i;
            ctc.add(c);
        }
        insert ctc;
    }
	 public static void genSalesAppt(Integer n, String cname) {
        List<Appointment__c> appmnt = new List<Appointment__c>();
        genCtact(n, cname);
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
			appmnt.add(ap);            
        }
        insert appmnt;
    }
}