public class CurrencyManager {

    public static String getURL(String nameOfMetadataType){
        List<Rest_services__mdt> informationFromMetadata = [SELECT DeveloperName, URL__c FROM Rest_services__mdt
        WHERE DeveloperName =: nameOfMetadataType];

        return informationFromMetadata.get(0).URL__c;
    }

}