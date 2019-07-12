@isTest
public class CurrencyManagerTest {

    @isTest
    private static void testgetURL (){

        String name = 'Currency_Rest_Service';

        Test.startTest();
        String testURL = CurrencyManager.getURL(name);
        Test.stopTest();

        System.assertEquals('http://www.nbrb.by/API/ExRates/Rates', testURL);
    }
}