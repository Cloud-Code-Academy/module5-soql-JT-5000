/**
 * The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
 * It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
 *
 * This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
 * a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
 * records, and manage data volume using the LIMIT keyword.
 *
 * Topics covered in this class include:
 * - Understanding the structure of a SOQL query.
 * - Crafting basic SELECT statements in SOQL.
 * - Applying filters using the WHERE clause in SOQL.
 * - Fetching related records using Relationship queries.
 * - Controlling the amount of data retrieved using the LIMIT keyword.
 *
 * Users of this class can expect to gain a solid understanding of SOQL in Apex and
 * be prepared to handle data retrieval tasks in Salesforce development.
 *
 * @author Your Name
 */

public with sharing class SOQL {
	/**
	 * Question 1
	 * Update/Uncomment the template code to create a method
	 * Returns all leads from Salesforce Org
	 * @return List of all leads with Id, LastName, Company, Phone, Email
	 * Update the corresponding test class and testGetAllLeads method to cover this method
	 */
	public static List<Lead> returnLeadList() {
		List<Lead> leadList = [SELECT Id, LastName, Company, Phone, Email 
							   FROM Lead 
							   LIMIT 200];

		return leadList;
	}

	/**
	 * Question 2
	 * Update/Uncomment the template code to create a method
	 * Returns all contacts with first name of John.
	 * @return A list of Contact records.
	 * Update the corresponding test class and testGetContactsByFirstName method to cover this method
	 */
	public static List<Contact> returnContactList(){
		List<Contact> contactList = [SELECT Id, FirstName, LastName, Name
									 FROM Contact 
									 WHERE FirstName = 'John'
									 LIMIT 200];

		return contactList;
	}

	/**
	 * Question 3
	 * Update/Uncomment the template code to create a method
	 * Returns the Contact Id for all contacts with last name of Smith or Jones
	 * @return A list of Contact Ids.
	 * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
	 */
	public static List<Id> returnContactIdsForLastNameOfSmithOrJones() {
		List<Id> listOfIDs = new List<Id>();
		List<Contact> listOfContacts = [SELECT Id
									    FROM Contact
									    WHERE LastName = 'Smith' OR LastName = 'Jones'
										LIMIT 200];

		for (Contact myContact : listOfContacts) {
			listOfIDs.add(myContact.Id);
		}
		return listOfIDs;

	}

	/**
	 * Question 4
	 * Update/Uncomment the template code to create a method
	 * Returns List of closed won opportunities for a specific Account.
	 * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A list of Opportunities with important opportunities fields
	 * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
	public static List<Opportunity> returnListOfOpps(String accountId){
		List<Opportunity> listOfOpportunities = [SELECT Id, Name, StageName, Description, AccountId, CloseDate, Amount
												 FROM Opportunity 
												 WHERE AccountId = :accountId AND StageName = 'Closed Won'
												 LIMIT 200];

		return listOfOpportunities;
	}

	/**
	 * Question 5
	 * Update/Uncomment the template code to create a method
	 * Returns the total count of Account records.
	 * @return The Integer count of Account records.
	 * Update the corresponding test class and testGetAccountCount method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
	public static Integer totalAccountRecordCount(){
		Integer totalCount = [SELECT COUNT()
							  FROM Account];
		System.debug(JSON.serializePretty(totalCount));
		return totalCount;
	}

	/**
	 * Question 6
	 * Update/Uncomment the template code to create a method
	 * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
	 * @return A map of Task Ids to Task records.
	 * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
	public static Map<Id,Task> returnTaskMap(){
		Map<Id,Task> taskIdToTaskMap = new Map<Id,Task>(
			[SELECT Id FROM Task WHERE ActivityDate = NEXT_N_DAYS:7 LIMIT 200]
		);

		return taskIdToTaskMap;
	}

	/**
	 * Question 7
	 * Update/Uncomment the template code to create a method
	 * Retrieves all Contacts that have a example.com domain in their Email.
	 * @return A list of Contact records.
	 * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
	public static List<Contact> returnListOfContacts(){
		List<Contact> contactsWithDomainList = [SELECT Id, Email, Name 
												FROM Contact 
												WHERE Email 
												LIKE '%example.com'
												LIMIT 200];

		if(contactsWithDomainList.isEmpty()){
			return null;
		}else{
			return contactsWithDomainList;
		}
	}

	/**
	 * Question 8
	 * Retrieves all Opportunities that have a specific keyword in their Name.
	 * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
	 * @param keyword The keyword to search for in the Opportunity Name.
	 * @return A list of Opportunity records.
	 */
	public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
		String wildCardKeyword = '%' + keyword + '%';
		List<Opportunity> oppsWithKeywordList = [SELECT Id, Name, StageName, CloseDate, AccountId
												 FROM Opportunity
												 WHERE Name 
												 LIKE :wildCardKeyword
												 LIMIT 200];

		return oppsWithKeywordList;
	}

	/**
	 * Question 9
	 * Retrieves all Cases that Case Origin is not Web or Email or Blank
	 * @return A list of Case records.
	 */
	public static List<Case> getFilterCaseOrigins() {
		List<Case> caseOriginNotWebOrEmailList = [SELECT Id, Origin
												  FROM Case
												  WHERE Origin NOT IN ('Web', 'Email', '')
												  LIMIT 200];

		return caseOriginNotWebOrEmailList;
	}

	/**
	 * Question 10
	 * Update/Uncomment the template code to create a method
	 * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
	 * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
	 * @param leadSource The Lead Source to search for.
	 * @param keyword The keyword to search for in the Lead Title.
	 * @return A list of Lead records.
	 * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
	public static List<Lead> returnLeadList(String leadSourceValue, String titleValue){
		String leadSourceString = '%' + leadSourceValue + '%';
		String titleValueString = '%' + titleValue + '%';
		List<Lead> leadsWithSourceAndTitleValueList = [SELECT Id, LastName, Phone, Company, Email, LeadSource, Title
													   FROM Lead
													   WHERE LeadSource LIKE :leadSourceString 
													   OR Title LIKE  :titleValueString
													   LIMIT 200];

		return leadsWithSourceAndTitleValueList;
	}

	/**
	 * Question 11
	 * Returns the names of all Contacts associated with an Account.
	 * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A list of Contact LastName.
	 */
	public static List<String> getContactNamesByAccount(Id accountId) {
		// Create a list to hold the Contact LastNames
		List<Contact> contactList = [SELECT Id, LastName 
										  FROM Contact
										  WHERE AccountId = :accountId];

		List<String> lastNameList = new List<String>();

		for (Contact contact : contactList) {
			lastNameList.add(contact.LastName);
		}

		return lastNameList;
	}

	/**
	 * Question 12
	 * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
	 * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for the found opportunities
	 * @param stage The Stage value to filter Opportunities.
	 * @return The total revenue.
	 */
	public static Decimal getTotalRevenueByStage(String stage) {
		// Use AggregateQuery to get the total revenue
		List<AggregateResult> oppAggregateResult = [SELECT SUM(Amount)
									 FROM Opportunity
									 WHERE StageName = :stage OR Amount > 10000];

		Decimal totalRevenue = 0;

		for (AggregateResult result : oppAggregateResult) {
			Object amount = result.get('expr0');
			totalRevenue = (Decimal)amount;
		}
		return totalRevenue; 
	}

	/**
	 * Question 13
	 * Retrieves the first 10 Accounts ordered by Name.
	 * @return A list of the first 10 Accounts ordered by Name.
	 */
	public static List<Account> getFirstTenAccounts() {
		List<Account> accountList = [SELECT Id, Name
									 FROM Account
									 ORDER BY Name
									 LIMIT 10 ];
									 System.debug(accountList);

									 return accountList;
	}

	/**
	 * Question 14
	 * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
	 * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
	 */
	public static List<Opportunity> getHighValueOpportunities() {
		List<Opportunity> opportunityList = [SELECT Id, Amount, CloseDate
											 FROM Opportunity
											 WHERE Amount > 100000
											 ORDER BY CloseDate
											 LIMIT 5];
		System.debug(JSON.serializePretty(opportunityList));

		return opportunityList;
	}

	/**
	 * Question 15
	 * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
	 * @return A list of Contacts
	 */
	public static List<Contact> getBirthdateContacts() {
		List<Contact> contactList = [SELECT Id, Birthdate
									 FROM Contact
									 ORDER BY Birthdate DESC 
									 LIMIT 3];
		System.debug(JSON.serializePretty(contactList));
		return contactList;
	}

	/**
	 * Question 16
	 * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
	 * @return A list of Cases
	 */
	public static List<Case> getCasesWithStatus() {
		List<Case> caseList = [SELECT Id, Status, CreatedDate
							   FROM Case
							   WHERE Status = 'Open'
							   ORDER BY CreatedDate
							   LIMIT 10
							   OFFSET 5];
		return caseList;
	}

	/**
	 * Question 17
	 * Returns Set of Case Ids for a specific Account.
	 * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A set of Case Ids.
	 */
	public static Set<Id> getCaseIdsByAccount(Id accountId) {
		// Create a set to hold the Case Ids
		Set<Id> setOfIDs = new Set<Id>();

		List<Case> listOfCases = [SELECT Id 
						 FROM Case
						 WHERE AccountId = :accountId];

		for (Case singleCase : listOfCases) {
			setOfIDs.add(singleCase.Id);
		}

		return setOfIDs; 
	}

	/**
	 * Question 18
	 * Return Map of Account Ids to Account Names Not in a specific Country.
	 * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
	 * @param country The country to filter Accounts.
	 * @return A map of Account Ids to Account Names.
	 */
	public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
		// Create a map to hold the Account Ids to Account Names
		Map<Id, String> accountIdsToNames = new Map<Id, String>();

		// Query the Accounts
		List<Account> accountsNotInCountryList = [SELECT Id, Name, BillingCountry
												  FROM Account 
												  WHERE BillingCountry != :country];

		// Loop through each Account and add the Id and Name to the map
		for (Account acct : accountsNotInCountryList) {
			accountIdsToNames.put(acct.Id, acct.Name);
			System.debug(accountIdsToNames);
		}

		return accountIdsToNames; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 19
	 * Retrieves the Account Name for a given Contact.
	 * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
	 * @param contactId The Id of the Contact.
	 * @return The Account Name of the Contact.
	 */
	public static String getAccountNameForContact(String contactId) {

		//example of an up query
		List<Contact> contactList = [SELECT Id, Account.Name
									 FROM Contact
									 WHERE Id = :contactId];
		System.debug(contactList[0].Account.Name);

		return contactList[0].Account.Name;
	}

	/**
	 * Question 20
	 * Returns single Account that has related opportunities in the same query
	 * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
	 * @param accountId The ID of the Account.
	 * @return An Account record with related Opportunities.
	 */
	public static Account getAccountAndOpportunitiesFromAccountId(Id accountId) {

		List<Account> listOfAccounts = [SELECT 
											Id, 
											Name, 
											(SELECT Id, Name FROM Opportunities)
										FROM Account
										WHERE Id = :accountId];

		System.debug(JSON.serializePretty(listOfAccounts));
		return listOfAccounts[0];
	}

	/**
	 * Question 21
	 * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
	 * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
	 * @param Account Id
	 * @return List of contacts with the same Mailing State as the Account Billing State
	 */
	public static List<Contact> getAccountsWithContactsByState(Id accountId) {
		// Query the Account
		Account singleAccount = [SELECT Id, BillingState
								 FROM Account 
								 WHERE Id = :accountId];

		// Store the Account's BillingState
		String accountBillingState = singleAccount.BillingState;

		// Query the Contacts
		List<Contact> relatedContactsList = [SELECT Id, MailingState
											 FROM Contact
											 WHERE MailingState = :accountBillingState];

		return relatedContactsList; 
	}

	/**
	 * Question 22
	 * Extracts email domains from them leads, then finds Accounts with matching website domains
	 * If Lead Email = test@test.com return account with website = www.test.com
	 * Example: findAccountsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
	 * @param A set of Lead Ids.
	 * @return A list of Accounts with matching email domains.
	 */
	public static List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
		// Query the Leads
		List<Lead> leadList = [SELECT Id, Email
							   FROM Lead 
							   WHERE Id IN :leadIds 
							   AND Email != null];

		// Create a set of email domains from the Leads
		Set<String> emailDomainSet = new Set<String>();

		for (Lead eachLead : leadList) {
			emailDomainSet.add(eachLead.Email.substringAfter('@').toLowerCase());
		}
		
		Set<String> createWebAddressSet = new Set<String>();

		for (String domain : emailDomainSet) {
			createWebAddressSet.add(domain);
			createWebAddressSet.add('www.' + domain);
		}

		List<Account> accountList = [SELECT Id, Name, Website
									 FROM Account
									 WHERE Website IN :createWebAddressSet];
		
		return accountList;
	}

	/**
	 * Question 23
	 * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
	 * Adds a randomized number between 1 to 3 to the quantity of each line item.
	 * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
	 * @param Original Opportunity Id
	 * @param List of cloned Opportunity Ids
	 */
	public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
		if (cloneOppIds.isEmpty()) {
			//Quit and go home
			return;
		}

		// Query the original Opportunity Line Items
		List<OpportunityLineItem> oppLineItems = [SELECT Id, PricebookEntryId, UnitPrice
												  FROM OpportunityLineItem
												  WHERE OpportunityId = :origOppId];

		if (oppLineItems.isEmpty()) {
			//Quit and go home
			return;
		}

		// Generate a random number between 1 and 3
		Integer randomNumber = Integer.valueOf(Math.floor(Math.random() * 3)) +1;

		List<OpportunityLineItem> newListOfLineItems = new List<OpportunityLineItem>();

		// Loop through each cloned Opportunity Id
		for (Id id : cloneOppIds) {
			for (OpportunityLineItem lineItem : oppLineItems) {

				OpportunityLineItem newOppLineItem = new OpportunityLineItem();

				newOppLineItem.Quantity = randomNumber;
				newOppLineItem.OpportunityId = id;
				newOppLineItem.PricebookEntryId = lineItem.PricebookEntryId;
				newOppLineItem.UnitPrice = lineItem.UnitPrice;
				newListOfLineItems.add(newOppLineItem);
			}
		}

		Database.insert(newListOfLineItems);

	}

	/**
	 * Question 24
	 * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
	 * @return A list of filtered Opportunity
	 */
	public static List<Opportunity> getOpportunityDetailsForClosedWon() {
		List<Opportunity> oppList = [SELECT Name, Account.Name, Owner.Name
									 FROM Opportunity
									 WHERE StageName = 'Closed Won'];

		return oppList;
	}

	/**
	 * Question 25
	 * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to the Contact on the associated Account with the alphabetically first first name.
	 * Example: if there are two Contacts on the Account, "Billy" and "Abby," the 'Primary_Contact__c' will be set to "Abby."
	 */
	public static void setPrimaryContact() {
		//Use the getOpportunityDetailsForClosedWon() method to get the Opportunities
		List<Opportunity> oppList = getOpportunityDetailsForClosedWon();

		// Create a set of Account Ids from the Opportunities
		Set<Id> accountIdSet = new Set<Id>();

		for (Opportunity opp : oppList) {
			accountIdSet.add(opp.AccountId);
		}

		// Query the Contacts
		List<Contact> contactList = [SELECT Id, FirstName, LastName, Account.Id
									 FROM Contact
									 WHERE AccountId IN :accountIdSet];
									 //Should I sort this list by FirstName in order to prepare for contacts to be overwritten in the map below?

		// Loop through each Contact and add the Account Id and Contact to the map
		Map<Id, Contact> idToContactMap = new Map<Id, Contact>();
		for (Contact eachContact : contactList) {
			idToContactMap.put(eachContact.AccountId, eachContact);
		}

		// Loop through each Opportunity
		for (Opportunity opp : oppList) {
			opp.Primary_Contact__c = idToContactMap.get(opp.AccountId).Id;
		}
		// Update the Opportunity primary contact from accountToContactMap
		Database.update(oppList);
		// Update the Opportunities
	}
}
