/**
 * Created by Brooks Johnson on 9/14/2021.
 */

//TODO build where  / and condition
//TODO build condition
//TODO build operator
//todo build predicate

@IsTest
private class Query_Tests {
    @IsTest
    static void itShouldCreateBasicQuery() {
        Query query = new Query(Account.SObjectType);

        System.assertEquals(query.type, Account.SObjectType, 'It should set SObjectType');
    }

    @IsTest
    static void itShouldSetQueryFields(){
        List<SObjectField> fields = new List<SObjectField>();
        fields.add(Account.Description);
        fields.add(Account.Name);
        fields.add(Account.AnnualRevenue);
        fields.add(Account.Id);
        Query query = new Query(Account.SObjectType);
        query.fields(fields);

        System.assertEquals(4, query.fields.size(), 'It should set fields');
    }

    /* @IsTest
     static void itShouldBuildIDFilter(){
         //given
         Query query = new Query(Account.SObjectType);
         //when
         query.filterById('12345');
         //then
         System.debug(query.idsToFilterBy);
         System.assert(query.idsToFilterBy != null);
     }*/

    @IsTest
    static void itShouldSetWhereClause() {
        List<SObjectField> fields = new List<SObjectField>{
                Account.Id, Account.Name, Account.AnnualRevenue
        };
        Query query = new Query(Account.SObjectType);
        query.fields(fields)
                .setWhere(Account.Id);

        System.assertEquals(query.currentFilter.condition, ' WHERE ', 'It should be set to WHERE');
        System.assertEquals(query.currentFilter.fieldToFilter, Account.Id, 'It should be set to Account Id');
    }
}