public class CurrencyManager {

    public static Rest_services__mdt getURL(String nameOfMetadataType){
        List<Rest_services__mdt> informationFromMetadata = [SELECT DeveloperName, URL__c FROM Rest_services__mdt
        WHERE DeveloperName =: nameOfMetadataType];
        if (informationFromMetadata.isEmpty()) {
            return null;
        }
        return informationFromMetadata.get(0);
    }
}
