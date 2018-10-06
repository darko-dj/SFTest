@isTest
private class AccountManagerTest
{
	@isTest
	static void testGetAccount()
	{
		// Create test data
		Account acct = new Account(Name='Test Account');
        insert acct;
        Contact con = new Contact(	FirstName='Test',
        							LastName='Contact',
                                    AccountId=acct.Id);
        insert con;
        // Perform test
        Test.startTest();

        RestRequest request = new RestRequest();
        request.requestUri 	= 'https://who-cares.my.salesforce.com/services/apexrest/Account/' + acct.Id + '/contacts';
        request.httpMethod 	= 'GET';
        RestContext.request = request;
        
        Account acc = AccountManager.getAccount();
        System.assertEquals(acct.Id, acc.Id, 'Same account retrieved');
    	System.assertEquals(1, acc.Contacts.size(), 'Number of contacts does not match');

        Test.stopTest();

	}
}