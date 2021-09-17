/**
 * Created by Brooks Johnson on 9/14/2021.
 */

public with sharing class Query {

    public SObjectType type { get; private set; }
    public List<SObjectField> fields { get; private set; }
    public Set<String> idsToFilterBy { get; private set; }
    public List<whereCondition> whereConditions;
    public whereCondition currentFilter { get; set; }


    public Query(SObjectType type) {
        this.type = type;
    }


    public Query fields(List<SObjectField> fields) {
        this.fields = fields;
        return this;
    }

    /*public Query filterById(String id){
        filterByIds(new Set<String>{id});
        return this;
    }*/

    /*public Query filterByIds(Set<String> idsToFilterBy){
        this.idsToFilterBy = idsToFilterBy;
        this.whereCondition = ' WHERE ID IN: idsToFilterBy';
        return this;
    }*/
    public Query setWhere(SObjectField field) {
        this.currentFilter = new whereCondition();
        currentFilter.condition = ' WHERE ';
        currentFilter.fieldToFilter = field;
        return this;
    }

    public class whereCondition {
        @TestVisible
        public String condition { get; private set; }
        @TestVisible
        public SObjectField fieldToFilter { get; private set; }

    }
}