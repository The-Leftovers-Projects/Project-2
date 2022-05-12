@isTest
public class DataFactory {
    
    // create dummy case data and return it for testing purposes
    public static List<Case> insertCases(Integer casesTotal, String setStatus) {
        List<Case> newCases = new List<Case>();

        for (Integer i = 0; i < casesTotal; i++) {
            newCases.add(new Case(Subject = 'TestCase' + i, Status = setStatus));
        }

        insert newCases;
        return newCases;
    }

}
