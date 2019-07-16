@isTest
public class CurrencyManagerTest {

    @isTest
    private static void testgetURL (){

        String name = 'Currency_Rest_Service';
        String name1 = 'Currency_Rest_Service1';

        Test.startTest();
        Rest_services__mdt testURL = CurrencyManager.getURL(name);
        Rest_services__mdt testURL1 = CurrencyManager.getURL(name1);
        Test.stopTest();

        System.assertEquals('http://www.nbrb.by/API/ExRates/Rates', testURL.URL__c);
        System.assertEquals(null, testURL1);
    }
    
    @IsTest
    private static void getListsTest(){
        
        Currency__c curr = createTestCurrency();
        insert curr;
        
        Test.startTest();
        List<Currency__c> currencies1 = CurrencyManager.getListOfCurrency(Date.valueOf('2019-7-7'), 'EUR');
        List<Currency__c> currencies2 = CurrencyManager.getListOfCurrency('EUR');
        List<Currency__c> currencies3 = CurrencyManager.getListOfCurrency(Date.valueOf('2019-7-7'));
        List<Currency__c> currencies4 = CurrencyManager.getListOfCurrency();
        Test.stopTest();
        
        System.assertEquals(1, currencies1.size());
        System.assertEquals('test', currencies1.get(0).Name);
        System.assertEquals(1, currencies2.size());
        System.assertEquals('EUR', currencies2.get(0).Currency__c);
        System.assertEquals(1, currencies3.size());
        System.assertEquals(Date.newInstance(2019, 7, 7), currencies3.get(0).Date__c);
    }  
    
    private static Currency__c createTestCurrency(){
        Currency__c curr = new Currency__c();
        curr.Name = 'test';
        curr.Date__c = Date.newInstance(2019, 7, 7);
        curr.Currency__c = 'EUR';
        return curr;
    }
}
