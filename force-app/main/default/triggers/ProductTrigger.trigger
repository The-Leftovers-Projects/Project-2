trigger ProductTrigger on Product2 (before insert) {
	System.debug('Welcome!');
}