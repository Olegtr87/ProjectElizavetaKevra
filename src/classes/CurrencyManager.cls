public class CurrencyManager {

    public static Rest_services__mdt getURL(String nameOfMetadataType){
        List<Rest_services__mdt> informationFromMetadata = [SELECT DeveloperName, URL__c FROM Rest_services__mdt
        WHERE DeveloperName =: nameOfMetadataType];
        if (informationFromMetadata.isEmpty()) {
            return null;
        }
        return informationFromMetadata.get(0);
    }

    public static List<SObject> getListOfCurrency(Map<String, Object> conditions){
        String query = 'SELECT Id, Name, Rate__c, Date__c, Currency__c FROM Currency__c';
        if (!conditions.isEmpty()) {
            query = query + ' WHERE ';
            for (String field : conditions.keySet()) {   
                    query = query + field + ' = ' + String.valueOf(conditions.get(field))+ ' AND ';
            }
            query = query.substringBeforeLast(' AND ');
        }
        List<SObject> result = Database.query(query);
        return result;
    }
}
