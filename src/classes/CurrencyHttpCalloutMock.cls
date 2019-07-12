public class CurrencyHttpCalloutMock {
    
    public static StaticResourceCalloutMock getMock(Integer statusCode){
        
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Currency');
        mock.setStatusCode(statusCode);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        return mock;
    }
}