@isTest
public class CurrencyWorkingScheduleTest {
    
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    
    @isTest
    private static void testScheduledJob()
    {
        Test.setMock(HttpCalloutMock.class, CurrencyHttpCalloutMock.getMock(200));
        Test.setMock(HttpCalloutMock.class, CurrencyHttpCalloutMock.getMock(400));
        Test.setMock(HttpCalloutMock.class, CurrencyHttpCalloutMock.getMock(404));
        
        List<Integer> codes = new List<Integer>(3);
        codes.add(145);
        codes.add(292);
        codes.add(298);
        
        Test.StartTest();
            String jobId = System.schedule('Daily Currency Updating'+System.now(),  CRON_EXP,  new CurrencyWorkingSchedule(codes));
            CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
            System.assertEquals(CRON_EXP, ct.CronExpression);
        Test.stopTest();

        List<Currency__c> listOfRates = [select Name, Rate__c, Date__c, Currency__c from Currency__c];
        System.assertEquals(1, listOfRates.size());
    }
}