/**
 * Created by Brooks Johnson 9/17/2021.
 * @Description used to test integration with data layer
 */

@IsTest
public with sharing class Selector_Tests_Integration {

    @TestSetup
    static void setup() {
        Account account = new Account(Name = 'Test Acc1', AnnualRevenue = 10.00, Description = 'Test Account');
        Account accountTwo = new Account(Name = 'Test Acc2', AnnualRevenue = 15.00, Description = 'Test Account Two');
        List<Account> accounts = new List<Account>{
                account, accountTwo
        };
        insert accounts;
    }
    @IsTest
    static void itShouldReturnAccounts(){
        //given
        List<SObjectField> sObjectFields = new List<SObjectField>{Account.Name, Account.AnnualRevenue,
        Account.Description};
        Query query = new Query(Account.SObjectType)
                .fields(sObjectFields);
        //when
        Selector selector = new Selector(query);
        selector.buildQuery();
        List<Account> accounts = selector.query();
        //then
        System.debug(accounts);
        System.assert(2 == accounts.size(), 'It should find all accounts');
    }

}