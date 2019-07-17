@RestResource(urlMapping='/Currencies/*')
global class CurrencyRestManager {

    @HttpGet
    global static List<Currency__c> getCurrency(){
        
        Map<String, Object> conditions = new Map<String, Object>();
        
        if (RestContext.request.params.get('date') != null) conditions.put('Date__c', Date.valueOf(RestContext.request.params.get('date')));
        if (RestContext.request.params.get('abbreviation') != null) conditions.put('Currency__c', RestContext.request.params.get('abbreviation'));
        
        return doGet(conditions);
    }

    public static List<SObject> doGet(Map<String, Object> conditions){
        List<SObject> result =  CurrencyManager.getListOfCurrency(conditions);
        return result;
    }
}
