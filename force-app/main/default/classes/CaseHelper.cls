public class CaseHelper {
    
    // trigger logic
    public static void PreventDeletion(List<Case> caseResults) {
        // grab only the cases that are in progress
        caseResults = [SELECT Status FROM Case WHERE NOT Status = 'Closed'];
        
        // for each case, add an error
        for (Case c : caseResults) {
            c.addError('Case is still in progress and cannot be deleted.');
        }
    }

    // testing methods
    @TestSetup
    static void makeData(){
        DataFactory.insertCases(5);
    }
}
