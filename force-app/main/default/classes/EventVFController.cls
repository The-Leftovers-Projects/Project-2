// rhys kim
// 05.15.2022
// controller for platform event

public class EventVFController {

    // create a new platform event
    NewApptEvent__e apptEvent = new NewApptEvent__e();

    // save the event to database in order for it to get published
    Database.SaveResult result = Eventbus.publish(apptEvent);

    // have the button publish the event
    public PageReference save() {
        // setup pages to send users to next page
        PageReference current = ApexPages.currentPage();
        PageReference wizard = Page.AppointmentPg1;

        System.debug('publishing event');

        wizard.setRedirect(true);
        return wizard;
    }
}