trigger CaseTrigger on Case (before delete) {
  CaseHelper.PreventDeletion(trigger.old);
}