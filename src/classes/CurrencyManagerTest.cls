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
        
        Map<String, Object> m1 = new Map<String, Object>();
		m1.put('Date__c', String.valueOf(Date.newInstance(2019, 7, 7)));
		m1.put('Currency__c', '\''+ 'EUR' +'\'');
        
        Test.startTest();
        List<SObject> objects = CurrencyManager.getListOfCurrency(m1);
        Test.stopTest();
        
        System.assertEquals(1, objects.size());
    }  
    
    private static Currency__c createTestCurrency(){
        Currency__c curr = new Currency__c();
        curr.Name = 'test';
        curr.Date__c = Date.newInstance(2019, 7, 7);
        curr.Currency__c = 'EUR';
        return curr;
    }
}
