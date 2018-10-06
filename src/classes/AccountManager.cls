@RestResource(urlMapping='/Account/*/contacts')
global with sharing class AccountManager {
	
	@HttpGet
	global static Account getAccount() {
		RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String uriWithoutLastSlash = request.requestURI.substring(0, request.requestURI.lastIndexOf('/'));
        String accountId = uriWithoutLastSlash.substring(uriWithoutLastSlash.lastIndexOf('/')+1);
        Account result =  [SELECT Id, Name, (SELECT Id, Name FROM Contacts) 
        				FROM Account
                        WHERE Id = :accountId
                        LIMIT 1];
        return result;
	}
}