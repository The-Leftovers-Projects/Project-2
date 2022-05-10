@isTest
private class CaseTester {

    @TestSetup
    static void makeData(){
        DataFactory.insertCases(5);
    }

    @IsTest
    static void testDeleteCaseWip(){
        Case caseWip = [SELECT Status FROM Case WHERE Subject = 'TestCase0' LIMIT 1];
        caseWip.Status = 'In Progress';
        update caseWip;

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
        Case caseClosed = [SELECT Status FROM Case WHERE Subject = 'TestCase0' LIMIT 1];
        // make sure it hasn't been updated from earlier test methods
        System.assertEquals('New', caseClosed.Status);
        caseClosed.Status = 'Closed';
        update caseClosed;

        Test.startTest();
        // this SHOULD delete the case
        Database.DeleteResult result = Database.delete(caseClosed, true);
        Test.stopTest();

        // the result should be a success
        System.assert(result.isSuccess());
    }

    @IsTest
    static void testDeleteCaseUnknown(){
        Case caseUnknown = [SELECT Status FROM Case WHERE Subject = 'TestCase0' LIMIT 1];
        // make sure it hasn't been updated from earlier test methods
        System.assertEquals('New', caseUnknown.Status);
        caseUnknown.Status = null;
        update caseUnknown;

        Test.startTest();
        Database.DeleteResult result = Database.delete(caseUnknown, false);
        Test.stopTest();
        
        // the result should be a fail, even if status is unknown
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Case is still in progress and cannot be deleted.', result.getErrors()[0].getMessage());
    }

    @IsTest
    static void testDeleteCaseBulk(){
        List<Case> caseBulk = [SELECT Subject, Status FROM Case LIMIT 5];
        
        // create new lists to test against
        List<Case> caseNotDelete = new List<Case>();
        List<Case> caseDelete = new List<Case>();

        for (Case case : caseBulk) {
            switch on case.Subject {
                when 'TestCase0' {
                    case.Status = 'In Progress';
                    update case;
                    caseNotDeleted.add(case);
                }
                when 'TestCase1' {
                    case.Status = 'Closed';
                    update case;
                    caseDeleted.add(case);
                }
                when 'TestCase2' {
                    case.Status = 'Closed Unresolved';
                    update case;
                    caseNotDeleted.add(case);
                }
                when 'TestCase3' {
                    case.status = 'Closed Resolved';
                    update case;
                    caseDeleted.add(case);
                }
                when else {
                    case.Status = 'Contacting';
                    update case;
                    caseNotDeleted.add(case);
                }
            }
        }
        
        Test.startTest();
        Database.DeleteResult[] resultPos = Database.delete(caseDelete, true);
        Database.DeleteResult[] resultNeg = Database.delete(caseNotDelete, false);
        Test.stopTest();
        
        // write assert here...
    }
}
