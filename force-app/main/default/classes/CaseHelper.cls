public class CaseHelper {
    // trigger logic
    public static void PreventDeletion(List<Case> cases) {
        // for each case, add an error
        for (Case c : cases) {
            if (c.Status != 'Closed') {
                c.addError('Case is still in progress and cannot be deleted.');
            }
        }
    }
}