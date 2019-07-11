@isTest
public class CurrencyWorkingClassTest{
    
    @isTest
    private static void testCreateCurrency(){

        String name = 'Currency_Rest_Service';

        List<Integer> codes = new List<Integer>();
        codes.add(145);
        
        Test.startTest();        
        CurrencyWorking working = new CurrencyWorking(codes, Date.today(), name);
        working.createCurrency('BYN', 2.3654);        
        Test.stopTest();
    }
    
    @isTest
    private static void testStart(){ 
        
        Test.setMock(HttpCalloutMock.class, CurrencyHttpCalloutMock.getMock(200));
        Test.setMock(HttpCalloutMock.class, CurrencyHttpCalloutMock.getMock(400));
        Test.setMock(HttpCalloutMock.class, CurrencyHttpCalloutMock.getMock(404));

        String name = 'Currency_Rest_Service';
        Test.startTest();
        List<Integer> codes = new List<Integer>();
        codes.add(145);
        CurrencyWorking currencies = new CurrencyWorking(codes, Date.today(), name);
        currencies.start();
        Test.stopTest();
        
        List<Currency__c> listOfRates = [select Name, Rate__c, Date__c, Currency__c from Currency__c];        
        System.assertEquals(1, listOfRates.size());      
    }
    
    
}
