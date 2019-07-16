@IsTest
private class CurrencyRestManagerTest {
	
    @IsTest
    private static void getCurrencyTest(){        
        Currency__c curr = createTestCurrency();
        insert curr;
        
        System.RestRequest request = new System.RestRequest();
        request.requestUri = 'https://ap4.salesforce.com/services/apexrest/Currencies?' + 'date=2019-7-7';
        request.httpMethod = 'GET';
        RestContext.request = request;
        List<Currency__c> thisCurrency = CurrencyRestManager.getCurrency();
        
        System.assertNotEquals(thisCurrency.size(), 0);
        System.assertEquals('test', thisCurrency.get(0).Name);
        System.assertEquals('EUR', thisCurrency.get(0).Currency__c);
        System.assertEquals(Date.newInstance(2019, 7, 7), thisCurrency.get(0).Date__c);
    }
    
    @IsTest
    private static void doGetTest(){
        
        Currency__c curr = createTestCurrency();
        insert curr;
        
        Test.startTest();
        List<Currency__c> currencies1 = CurrencyRestManager.doGet('2019-7-7', 'EUR');
        List<Currency__c> currencies2 = CurrencyRestManager.doGet('','EUR');
        List<Currency__c> currencies3 = CurrencyRestManager.doGet('2019-7-7','');
        List<Currency__c> currencies4 = CurrencyRestManager.doGet('','');
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
