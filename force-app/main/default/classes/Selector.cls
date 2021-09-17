/**
 * Created by Brooks Johnson on 9/14/2021.
 *
 * @Description the Selector class serves as the director in the builder pattern used to create
 * the final query
 */

public with sharing virtual class Selector {
    private String selectStatement;
    private String fromStatement;
    private Query query;
    public String queryString { get; private set; }
    public Set<String> idsToFilterBy;

    public Selector(Query query) {
        this.query = query;
        this.idsToFilterBy = query.idsToFilterBy;
    }

    public void buildQuery() {
        this.selectStatement = buildForStatement(this.query.fields);
        this.fromStatement = buildFromStatement(this.query.type);
    }

    public String buildForStatement(List<SObjectField> queryFields) {
        return 'SELECT ' + buildFieldNameString(query.fields);
    }

    public String buildFromStatement(SObjectType type) {
        return ' FROM ' + type;
    }

    public List<SObject> query() {
        return Database.query(this.selectStatement + this.fromStatement);
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
}