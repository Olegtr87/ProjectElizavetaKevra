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
        
        Map<String, Object> m1 = new Map<String, Object>();
		m1.put('Date__c', String.valueOf(Date.newInstance(2019, 7, 7)));
		m1.put('Currency__c', '\''+ 'EUR' +'\'');
                
        Test.startTest();
        List<SObject> objects = CurrencyRestManager.doGet(m1);
        Test.stopTest();
        
        System.assertNotEquals(0, objects.size());
    }   
    
    private static Currency__c createTestCurrency(){
        Currency__c curr = new Currency__c();
        curr.Name = 'test';
        curr.Date__c = Date.newInstance(2019, 7, 7);
        curr.Currency__c = 'EUR';
        return curr;
    }
}
