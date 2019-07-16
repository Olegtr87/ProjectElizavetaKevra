public class CurrencyManager {

    public static Rest_services__mdt getURL(String nameOfMetadataType){
        List<Rest_services__mdt> informationFromMetadata = [SELECT DeveloperName, URL__c FROM Rest_services__mdt
        WHERE DeveloperName =: nameOfMetadataType];
        if (informationFromMetadata.isEmpty()) {
            return null;
        }
        return informationFromMetadata.get(0);
    }
    
    
    public static List<Currency__c> getListOfCurrency(Date specialDate){
        List<Currency__c> result =  [SELECT Id, Name, Rate__c, Date__c, Currency__c FROM Currency__c
        WHERE Date__c = :specialDate];
        return result;
    }

    public static List<Currency__c> getListOfCurrency(String abbreviation){
        List<Currency__c> result =  [SELECT Id, Name, Rate__c, Date__c, Currency__c FROM Currency__c
        WHERE Currency__c = :abbreviation];
        return result;
    }
    
    public static List<Currency__c> getListOfCurrency(){
        List<Currency__c> result =  [SELECT Id, Name, Rate__c, Date__c, Currency__c FROM Currency__c];
        return result;
    }
    public static List<Currency__c> getListOfCurrency(Date specialDate, String abbreviation){
        List<Currency__c> result =  [SELECT Id, Name, Rate__c, Date__c, Currency__c FROM Currency__c
        WHERE Date__c = :specialDate AND Currency__c = :abbreviation];
        return result;
    }

    
}
