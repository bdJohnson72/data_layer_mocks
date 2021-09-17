/**
 * Created by Brooks Johnson on 9/14/2021.
 *
 * @Description the Selector class serves as the director in the builder pattern used to create
 * the final query
 */

public with sharing virtual class Selector {
    private Query query;
    public String queryString {get; private set; }

    public Selector(Query query) {
        this.query = query;
    }

    public void buildQuery() {
        String queryString = 'SELECT ' +
                buildFieldNameString(query.fields) +
                ' FROM ' +
                buildWhereClause(this.query.whereConditions) +
                this.query.type;

        this.queryString = queryString;
    }

    public List<SObject> query(){
        return Database.query(this.queryString);
     }

    /**
     * @param sObjectFields fields to be used in the query
     *
     * @return string of field names
     */
    @TestVisible
    private String buildFieldNameString(List<SObjectField> sObjectFields) {
        Set<String> fieldNameSet = new Set<String>();
        for (SObjectField field : sObjectFields){
            fieldNameSet.add(field.getDescribe().getName());
        }
        String fieldNameString = String.join(new List<String>(fieldNameSet), ',');
        return fieldNameString;
      }

    public String buildWhereClause(List<Query.WhereCondition> whereConditions) {
        String whereString = ' WHERE ';
        if (whereConditions.isEmpty()) {
	        return '';
        }else {
            for (Query.WhereCondition whereCondition : whereConditions){
             whereString += buildClause(whereCondition);
            }
        }
        return whereString;
    }
    private String buildClause(Query.WhereCondition whereCondition){
        if (whereCondition.idsToFilterBy != null) {
            return ' id IN: ' + whereCondition.idsToFilterBy;
        }
        return null;
    }
}