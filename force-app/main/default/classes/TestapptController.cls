@isTest
public class TestapptController {
    @testSetup
     static void creatData() {
        TestData.genAppt(151);
        }
    @isTest
    static void testController() {
        ApptController apContr = new ApptController();
        Test.startTest();
        apContr.apptToday();
        Test.stopTest();
        Integer apNum = apContr.salesByDate.size();
        Integer count = 0;
        for(Appointment__c ap : apContr.salesByDate) {
        	String apDate = ap.Time__c.date().format();
           		if(apDate == '5/12/2022') {
                	count++;
            	}
        }
        System.assert(apContr.salesByDate != null);
        System.assertEquals(apNum, count);
    }
    @isTest
    static void testControllerPlus() {
        ApptController apContr = new ApptController();
        Test.startTest();
        apContr.fwdADay();
        Test.stopTest();
        Integer apNum = apContr.salesByDate.size();
        Integer count = 0;
        for(Appointment__c ap : apContr.salesByDate) {
        	String apDate = ap.Time__c.date().format();
           		if(apDate == '5/13/2022') {
                	count++;
            	}
        }
        System.assert(apContr.salesByDate != null);
        System.assertEquals(apNum, count);
  	}
    @isTest
    static void testControllerMinus() {
        ApptController apContr = new ApptController();
        Test.startTest();
        apContr.backADay();
        Test.stopTest();
        Integer apNum = apContr.salesByDate.size();
        Integer count = 0;
        for(Appointment__c ap : apContr.salesByDate) {
        	String apDate = ap.Time__c.date().format();
           		if(apDate == '5/11/2022') {
                	count++;
            	}
        }
        System.assert(apContr.salesByDate != null);
        System.assertEquals(apNum, count);
  	}
    
}