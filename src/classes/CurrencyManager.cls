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
        Integer i = 0;
        String query = 'SELECT Id, Name, Rate__c, Date__c, Currency__c FROM Currency__c';
        if (!conditions.isEmpty()) {
            query = query + ' WHERE ';
            for (String field : conditions.keySet()) {                
                if(field == 'Currency__c'){
                    if(i>0){
                        query = query + ' AND ';
                    }
                    i++;
                    String abbr = String.valueOf(conditions.get(field));
                    query = query + field + '=: abbr ';
                }               
                if(field == 'Date__c'){
                    if(i>0){
                        query = query + ' AND ';
                    }
                    i++;
                    Date theDate = Date.valueOf(String.valueOf(conditions.get(field)));                    
                    query = query + field + '=: theDate ';
                }  
            }
        }
        List<SObject> result = Database.query(query);
        return result;
    }    
}
