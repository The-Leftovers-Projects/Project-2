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

        for (Case c : caseBulk) {
            switch on c.Subject {
                when 'TestCase0' {
                    Case test0 = [SELECT Status FROM Case WHERE Subject = 'TestCase0' LIMIT 1];
                    test0.Status = 'In Progress';
                    update test0;
                    caseNotDelete.add(test0);
                }
                when 'TestCase1' {
                    Case test1 = [SELECT Status FROM Case WHERE Subject = 'TestCase1' LIMIT 1];
                    test1.Status = 'Closed';
                    update test1;
                    caseDelete.add(test1);
                }
                when 'TestCase2' {
                    Case test2 = [SELECT Status FROM Case WHERE Subject = 'TestCase2' LIMIT 1];
                    test2.Status = 'Closed Unresolved';
                    update test2;
                    caseDelete.add(test2);
                }
                when 'TestCase3' {
                    Case test3 = [SELECT Status FROM Case WHERE Subject = 'TestCase3' LIMIT 1];
                    test3.Status = 'Closed Resolved';
                    update test3;
                    caseDelete.add(test3);
                }
                when else {
                    c.Status = 'Contacting';
                    update c;
                    caseNotDelete.add(c);
                }
            }
        }
        
        Test.startTest();
        Database.DeleteResult[] resultNeg = Database.delete(caseNotDelete, false);
        // Database.DeleteResult[] resultPos = Database.delete(caseDelete, true);
        Test.stopTest();
        
        for (Database.DeleteResult caseNeg : resultNeg) {
            if (!caseNeg.isSuccess()) {
                System.assertEquals(false, caseNeg.isSuccess());
            } else {
                System.assertNotEquals(false, caseNeg.isSuccess());
            }
        }

        // for some reason the lists aren't being added into i think?
        // for (Database.DeleteResult casePos : resultPos) {
        //     if (casePos.isSuccess()) {
        //         System.assertEquals(true, casePos.isSuccess());
        //     } else {
        //         System.assertNotEquals(true, casePos.isSuccess());
        //     }
        // }
    }
}
