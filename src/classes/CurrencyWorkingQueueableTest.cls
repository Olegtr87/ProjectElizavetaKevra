@isTest
global class CurrencyWorkingQueueableTest{
    @isTest
    private static void testExecute(){
        
        Test.setMock(HttpCalloutMock.class, CurrencyHttpCalloutMock.getMock());
        
        Test.startTest();        
        System.enqueueJob(new CurrencyWorkingQueueable());    
        Test.stopTest();
    }
}