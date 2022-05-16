// rhys kim
// 05.12.2022
// project 2
// create trigger to prevent case deletion

public class CaseHelper {
    // trigger logic
    public static void PreventDeletion(List<Case> cases) {
        // for each case, add an error
        for (Case c : cases) {
            if (!c.Status.contains('Closed')) {
                c.addError('Case is still in progress and cannot be deleted.');
            }
        }
    }
}