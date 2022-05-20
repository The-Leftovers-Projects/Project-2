@IsTest
public class TestApptUtility {
    
    @TestSetup
    public static void genData() {
        TestData.genAppt(20);
    }
    @IsTest
    public static void testAU() {
        try {
             test.startTest();
             List<Appointment__c> duplicate = [SELECT Salesperson__c, Time__c FROM Appointment__c WHERE Description__c = 'This is Appointment # 0'];
             ApptUtility.noDoubleBooking(duplicate);
             test.stopTest();
        }
        catch(BookingException e) {
            System.assert(e != null);
        }
    }
}