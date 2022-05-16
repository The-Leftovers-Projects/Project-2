public class ApptController {
    
    //create the lists to populate the table showing the appointments
    
    public List<Appointment__c> allSales {
        get {
            return [SELECT Time__c, Salesperson__c, Contact__c, Description__c FROM Appointment__c WHERE Type__c = 'Sales'];
        }
    }
    public List<Appointment__c> salesByDate {
        get{
            if(salesByDate == null) {
                salesByDate = new List<Appointment__c>();
                for(Appointment__c appt : allSales) {
                    salesByDate.add(appt);
                }
            }
        return salesByDate;    
        }
        set;
    }
    
    //create an integer the methods will use to set the date for which to retrieve records
    
    private Integer nDays = 0;
    
    //create a method to display today's sales appointments and reset the day counter
       
    public void apptToday() {
        nDays = 0;
        salesByDate = new List<Appointment__c>();
        for(Appointment__c appt : allSales) {
            if(appt.Time__c.date() == Date.today()) {
            	salesByDate.add(appt);    
            }
        }       
    }
    
    //create a method to move forward a day on every click of the >> button
    
    public void fwdADay() {
        nDays++;
		salesByDate = new List<Appointment__c>();
        for(Appointment__c appt: allSales) {
            if(appt.Time__c.date() == Date.today().addDays(nDays)) {
                salesByDate.add(appt);
            }
        }
    }
    
    //create a method to move back a day on every click of the << button
    
    public void backADay() {
        nDays--;
		salesByDate = new List<Appointment__c>();
        for(Appointment__c appt: allSales) {
            if(appt.Time__c.date() == Date.today().addDays(nDays)) {
                salesByDate.add(appt);
            }
        }
    }
    
    //create a method to reset back to show all appointments
    
    public void reset() {
        salesByDate = null;
    }
}