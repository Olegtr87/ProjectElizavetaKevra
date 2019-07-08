public class CurrencyWorkingClass {
    
	static List<WorkWithCurrency.Rate> listOfRates = new List<WorkWithCurrency.Rate>();     
    
    public static void start(){        
        restRequest('145');//USD
        restRequest('292');//EUR
        restRequest('298');//RUB
        
        for(WorkWithCurrency.Rate rate : listOfRates){
            createCurrency(rate.Cur_Abbreviation, rate.Cur_OfficialRate);
        }
    }
    
	public static void restRequest(String code){
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://www.nbrb.by/API/ExRates/Rates/' + code);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        if(response.getStatusCode()!=200){
            System.debug('Page cannot be found.');
            System.debug('Status code: '+response.getStatusCode());
        }
        else{
            String jsonString = response.getBody();            
            WorkWithCurrency.Rate rate = (WorkWithCurrency.Rate)JSON.deserialize(jsonString, WorkWithCurrency.Rate.class);
            
            listOfRates.add(rate);
        }
    }
        
    public static void createCurrency(String abbreviation, Decimal rate){
        
        Currency__c newCurrency = new Currency__c();
        
        newCurrency.Name = abbreviation + ' ' + String.valueOf(Date.today());
        newCurrency.Date__c = Date.today();
        newCurrency.Currency__c = abbreviation;
        newCurrency.Rate__c = rate;
        
        Database.SaveResult sv = Database.insert(newCurrency);
    }
    
    public class Rate{
        public String Cur_ID;
        public String Cur_Abbreviation; 
        public String Cur_Scale;
        public String Cur_Name;
        public Decimal Cur_OfficialRate;
    }
}