@isTest
public class CurrencyWorkingClassTest{
    
    @isTest
    private static void testCreateCurrency(){
        
        Test.startTest();        
        CurrencyWorkingClass.createCurrency('BYN', 2.3654);        
        Test.stopTest();
        
        List<Currency__c> currencies = [select Name, Rate__c, Date__c, Currency__c from Currency__c];
        
        System.assertEquals(1, currencies.size());        
        System.assertEquals('BYN'+ ' ' + String.valueOf(Date.today()), currencies[0].Name);
        System.assertEquals(Date.today(), currencies[0].Date__c);        
        System.assertEquals('BYN', currencies[0].Currency__c);
        System.assertEquals(2.3654, currencies[0].Rate__c);
    }
    
    @isTest
    private static void testStart(){ 
        
        Test.setMock(HttpCalloutMock.class, CurrencyHttpCalloutMock.getMock(200));
        Test.setMock(HttpCalloutMock.class, CurrencyHttpCalloutMock.getMock(400));
        Test.setMock(HttpCalloutMock.class, CurrencyHttpCalloutMock.getMock(404));


        Test.startTest();
        Integer[] codes = new Integer[]{145, 298, 292};
        CurrencyWorking currencies = new CurrencyWorking(codes);
        currencies.start();
        Test.stopTest();
        
        List<Currency__c> listOfRates = [select Name, Rate__c, Date__c, Currency__c from Currency__c where Date__c =: Date.today()];
        
        System.assertEquals(3, listOfRates.size());        
    }

}
