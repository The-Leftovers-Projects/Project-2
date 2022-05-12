@isTest
private class CaseTester {

    @IsTest
    static void testDeleteCaseWip(){
        Case[] caseWip = DataFactory.insertCases(1, 'In Progress');

        Test.startTest();
        // go into the database and delete the case
        Database.DeleteResult result = Database.delete(caseWip[0], false);
        Test.stopTest();

        // the result should be a fail
        // check the database result and see what happened
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Case is still in progress and cannot be deleted.', result.getErrors()[0].getMessage());
    }

    @IsTest
    static void testDeleteCaseClosed() {
        Case[] caseClosed = DataFactory.insertCases(1, 'Closed');

        Test.startTest();
        // this SHOULD delete the case
        Database.DeleteResult result = Database.delete(caseClosed[0], true);
        Test.stopTest();

        // the result should be a success
        System.assert(result.isSuccess());
    }

    @IsTest
    static void testDeleteCaseUnknown(){
        Case[] caseUnknown = DataFactory.insertCases(1, null);

        Test.startTest();
        Database.DeleteResult result = Database.delete(caseUnknown[0], false);
        Test.stopTest();
        
        // the result should be a fail, even if status is unknown
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Case is still in progress and cannot be deleted.', result.getErrors()[0].getMessage());
    }

    @IsTest
    static void testDeleteCaseBulk(){
        List<Case> caseBulk = DataFactory.insertCases(5, null);
        
        // create new lists to test against
        List<Case> caseNotDelete = new List<Case>();
        List<Case> caseDelete = new List<Case>();

        // loop through the query and update cases with various statuses
        // add cases to appropriate lists
        for (Case c : caseBulk) {
            switch on c.Subject {
                when 'TestCase0' {
                    Case test0 = caseBulk[0];
                    test0.Status = 'In Progress';
                    update test0;
                    caseNotDelete.add(test0);
                }
                when 'TestCase1' {
                    Case test1 = caseBulk[1];
                    test1.Status = 'Closed';
                    update test1;
                    caseDelete.add(test1);
                }
                when 'TestCase2' {
                    Case test2 = caseBulk[2];
                    test2.Status = 'Closed Unresolved';
                    update test2;
                    caseDelete.add(test2);
                }
                when 'TestCase3' {
                    Case test3 = caseBulk[3];
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
        Database.DeleteResult[] resultPos = Database.delete(caseDelete, true);
        Test.stopTest();
        
        // loop through each list and make sure the results are as expected
        for (Database.DeleteResult caseNeg : resultNeg) {
            if (!caseNeg.isSuccess()) {
                System.assertEquals(false, caseNeg.isSuccess());
            } else {
                System.assertNotEquals(false, caseNeg.isSuccess());
            }
        }

        for (Database.DeleteResult casePos : resultPos) {
            if (casePos.isSuccess()) {
                System.assertEquals(true, casePos.isSuccess());
            } else {
                System.assertNotEquals(true, casePos.isSuccess());
                System.assert(casePos.getErrors().size() > 0);
                System.assertEquals('Case is still in progress and cannot be deleted.', casePos.getErrors()[0].getMessage());
            }
        }
    }
}
