/**
 * Created by Brooks Johnson on 9/14/2021.
 */

public with sharing class Query {

    public SObjectType type { get; private set; }
    public List<SObjectField> fields { get; private set; }
    public List<WhereCondition> whereConditions { get; private set; }

    public Query(SObjectType type) {
        this.type = type;
        this.whereConditions = new List<WhereCondition>();
    }


    public Query fields(List<SObjectField> fields) {
        this.fields = fields;
        return this;
    }

    public Query filterById(String id) {
        filterByIds(new Set<String>{
                id
        });
        return this;
    }

    public Query filterByIds(Set<String> idsToFilterBy) {
        this.whereConditions.add(new WhereCondition(idsToFilterBy));
        return this;
    }

    public class WhereCondition {
        public Set<String> idsToFilterBy {get; set; }

        public WhereCondition(Set<String> idsToFilterBy) {
            this.idsToFilterBy = idsToFilterBy;
        }
    }
}