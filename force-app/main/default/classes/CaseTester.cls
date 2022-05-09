@isTest
public class CaseTester {
    @TestSetup
    static void makeData(){
        DataFactory.insertCases(10);
    }

    @IsTest
    static void testPreventDeletion(){
        
        Test.startTest();
        // testing logic
        Test.stopTest();
        
    }
}
