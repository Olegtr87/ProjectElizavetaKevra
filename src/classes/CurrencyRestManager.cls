@RestResource(urlMapping='/Currencies/*')
global class CurrencyRestManager {

    @HttpGet
    global static List<Currency__c> getCurrency(){
        
        if(RestContext.request.params.get('date')!=null || RestContext.request.params.get('abbreviation')==null){
            return doGet(Date.valueOf(RestContext.request.params.get('date')));
        }
        else if(RestContext.request.params.get('date')==null || RestContext.request.params.get('abbreviation')!=null){
            return doGet(RestContext.request.params.get('abbreviation'));
        }
        else{
            return doGet(Date.valueOf(RestContext.request.params.get('date')), RestContext.request.params.get('abbreviation'));
        }
    }
    
    public static List<Currency__c> doGet(Date specialDate, String abbreviation){        
        List<Currency__c> result =  [SELECT Id, Name, Rate__c, Date__c, Currency__c FROM Currency__c 
                                     WHERE Date__c = :specialDate AND Currency__c = :abbreviation];
        return result;
    }
    
    public static List<Currency__c> doGet(Date specialDate){        
        List<Currency__c> result =  [SELECT Id, Name, Rate__c, Date__c, Currency__c FROM Currency__c 
                                     WHERE Date__c = :specialDate];
        return result;
    }
    
    public static List<Currency__c> doGet(String abbreviation){
        List<Currency__c> result =  [SELECT Id, Name, Rate__c, Date__c, Currency__c FROM Currency__c 
                                     WHERE Currency__c = :abbreviation];
        return result;
    }
}