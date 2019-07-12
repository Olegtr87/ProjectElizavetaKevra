@isTest
global class CurrencyWorkingQueueableTest{
    @isTest
    private static void testExecute(){

        Test.setMock(HttpCalloutMock.class, CurrencyHttpCalloutMock.getMock(200));
        Test.setMock(HttpCalloutMock.class, CurrencyHttpCalloutMock.getMock(400));
        Test.setMock(HttpCalloutMock.class, CurrencyHttpCalloutMock.getMock(404));
        
        List<Integer> codes = new List<Integer>(3);
        codes.add(145);
        codes.add(292);
        codes.add(298);
        String name = 'Currency_Rest_Service';
        
        Test.startTest();        
        System.enqueueJob(new CurrencyWorkingQueueable(codes, Date.today(), name));
        Test.stopTest();

        List<Currency__c> listOfRates = [select Name, Rate__c, Date__c, Currency__c from Currency__c];
        System.assertEquals(1, listOfRates.size());
    }
}
