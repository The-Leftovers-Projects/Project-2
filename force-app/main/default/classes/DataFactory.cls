@isTest
public class DataFactory {
    
    // create dummy case data and return it for testing purposes
    public static void insertCases(Integer casesTotal) {
        List<Case> newCases = new List<Case>();

        for (Integer i = 0; i < casesTotal; i++) {
            newCases.add(new Case(Subject = 'TestCase' + i));
        }

        Insert newCases;
    }

}
