public class CurrencyManager {

    public static String getURL(String nameOfMetadataType){
        List<Rest_services__mdt> informationFromMetadata = [SELECT DeveloperName, URL__c FROM Rest_services__mdt
        WHERE DeveloperName =: nameOfMetadataType];
        if(informationFromMetadata.get(0).URL__c != null){
            return informationFromMetadata.get(0).URL__c;
        }
        else{
            NullPointerException nullException = new NullPointerException();
            nullException.getMessage();
            return '';
        }
    }
}
