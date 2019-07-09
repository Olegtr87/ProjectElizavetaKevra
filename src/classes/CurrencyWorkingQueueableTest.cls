@isTest
global class CurrencyWorkingQueueableTest{
    @isTest
    private static void testExecute(){

        Test.setMock(HttpCalloutMock.class, CurrencyHttpCalloutMock.getMock(200));
        Test.setMock(HttpCalloutMock.class, CurrencyHttpCalloutMock.getMock(400));
        Test.setMock(HttpCalloutMock.class, CurrencyHttpCalloutMock.getMock(404));
        
        Test.startTest();        
        System.enqueueJob(new CurrencyWorkingQueueable());    
        Test.stopTest();

        List<Currency__c> listOfRates = [select Name, Rate__c, Date__c, Currency__c from Currency__c];
        System.assertEquals(3, listOfRates.size());
    }
}
