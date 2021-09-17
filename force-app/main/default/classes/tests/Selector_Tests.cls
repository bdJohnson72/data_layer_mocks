/**
 * Created by brooks Johnson on 9/14/2021.
 */

@IsTest
private class Selector_Tests {
    @IsTest
    static void itShouldQuery() {
        //given
        Query query = new Query(Account.SObjectType);

        //when
        Selector selector = new Selector(query);

        //then
        System.assertEquals(Account.SObjectType, query.type, 'It should set the SObjectType');
    }

    @IsTest
    static void itShouldBuildFieldNameString() {
        //given
        List<SObjectField> sObjectFields = new List<SObjectField>{
                Account.Name,
                Account.AnnualRevenue, Account.Description
        };
        Query query = new Query(Account.SObjectType).fields(sObjectFields);
        //when
        Selector selector = new Selector(query);
        selector.buildQuery();
        String fieldNameString = selector.buildFieldNameString(sObjectFields);
        //then
        System.assertEquals(true, fieldNameString.contains('Description'),
                'It should build the field name in the string');
    }

    @IsTest
    static void itShouldBuildForStatement() {
        //given
        List<SObjectField> sObjectFields = new List<SObjectField>{
                Account.Name,
                Account.AnnualRevenue, Account.Description
        };
        Query query = new Query(Account.SObjectType).fields(sObjectFields);
        //when
        Selector selector = new Selector(query);
        String forStatement = selector.buildForStatement(sObjectFields);
        //then
        System.assertNotEquals(null, forStatement, 'It should build the for statement');
    }

    @IsTest
    static void itShouldBuildFromStatement() {
        //given
        List<SObjectField> sObjectFields = new List<SObjectField>{
                Account.Name,
                Account.AnnualRevenue, Account.Description
        };
        Query query = new Query(Account.SObjectType).fields(sObjectFields);
        //when
        Selector selector = new Selector(query);
        String fromStatement = selector.buildFromStatement(Account.SObjectType);
        //then
        System.assert(fromStatement.contains('Account'), 'It should create the appropriate from statement');
    }
    @IsTest
    static void itShouldBuildIdFilter() {
        //given
        /* List<SObjectField> sObjectFields = new List<SObjectField>{Account.Name,
                 Account.AnnualRevenue, Account.Description};
         Query query = new Query(Account.SObjectType)
                 .fields(sObjectFields)
                 .filterById('12345');
         //when
         Selector selector = new Selector(query);
         selector.buildQuery();
         String whereCondition = selector.buildWhereClause(query.whereConditions[0]);*/
    }
}