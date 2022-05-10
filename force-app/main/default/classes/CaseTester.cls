@isTest
private class CaseTester {

    @IsTest
    static void testDeleteCaseWip(){
        Case caseWip = new Case(Status = 'In Progress');
        insert caseWip;

        Test.startTest();
        // go into the database and delete the case
        Database.DeleteResult result = Database.delete(caseWip, false);
        Test.stopTest();

        // the result should be a fail
        // check the database result and see what happened
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Case is still in progress and cannot be deleted.', result.getErrors()[0].getMessage());
    }

    @IsTest
    static void testDeleteCaseClosed() {
        Case caseClosed = new Case(Status = 'Closed');
        insert caseClosed;

        Test.startTest();
        // this SHOULD delete the case
        Database.DeleteResult result = Database.delete(caseClosed, true);
        Test.stopTest();

        // the result should be a success
        System.assert(result.isSuccess());
    }

    @IsTest
    static void testDeleteCaseUnknown(){
        Case caseUnknown = new Case(Status = '');
        insert caseUnknown;

        Test.startTest();
        Database.DeleteResult result = Database.delete(caseUnknown, false);
        Test.stopTest();
        
        // the result should be a fail, even if status is unknown
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Case is still in progress and cannot be deleted.', result.getErrors()[0].getMessage());
    }
}
