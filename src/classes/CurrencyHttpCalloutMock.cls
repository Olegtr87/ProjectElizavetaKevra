public class CurrencyHttpCalloutMock {
    
    public static StaticResourceCalloutMock getMock(){     
        
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Currency');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        return mock;
    }
}