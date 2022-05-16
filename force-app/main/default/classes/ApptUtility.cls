public class ApptUtility {
    public static void noDoubleBooking(List<Appointment__c> newAppts) {
        List<Appointment__c> ExistingAppts = [SELECT Type__c, Salesperson__c, Time__c FROM Appointment__c WHERE Type__c = 'Sales'];
        for(Appointment__c appt : newAppts) {
            for(Appointment__c a : ExistingAppts) {
                if(appt.Salesperson__c == a.Salesperson__c && appt.Time__c == a.Time__c) {
                    throw new BookingException('An appointment already exists at this time with this salesperon');
                } 
            }
        }
    }
}