@isTest
public class CurrencyWorkingScheduleTest {
    
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    
    @isTest
    private static void testScheduledJob()
    {
        Test.setMock(HttpCalloutMock.class, CurrencyHttpCalloutMock.getMock(200));
        Test.setMock(HttpCalloutMock.class, CurrencyHttpCalloutMock.getMock(400));
        Test.setMock(HttpCalloutMock.class, CurrencyHttpCalloutMock.getMock(404));
        
        Test.StartTest();
            String jobId = System.schedule('Daily Currency Updating'+System.now(),  CRON_EXP,  new CurrencyWorkingSchedule ());
            CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
            System.assertEquals(CRON_EXP, ct.CronExpression);
        Test.stopTest();

        List<Currency__c> listOfRates = [select Name, Rate__c, Date__c, Currency__c from Currency__c];
        System.assertEquals(3, listOfRates.size());
    }
}
