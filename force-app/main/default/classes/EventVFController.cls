// rhys kim
// 05.15.2022
// controller for platform event

public with sharing class EventVFController {
    // listen to platform event
    NewApptEvent__e apptEvent = new NewApptEvent__e(Customer_Name__c = 'New Customer');
    
    Database.SaveResult result = Eventbus.publish(apptEvent);

    if (result.isSuccess()) {
        System.debug('New appointment event successfully published!');
    } else {
        for(Database.Error err : result.getErrors()) {
            System.debug('Error returned: ' +
                         err.getStatusCode() +
                         ' - ' +
                         err.getMessage());
        }
    }
}