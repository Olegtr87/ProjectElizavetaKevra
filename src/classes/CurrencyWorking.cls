public class CurrencyWorking {

    private List<WorkWithCurrency.Rate> listOfRates = new List<WorkWithCurrency.Rate>();
    private List<Currency__c> listOfCurrencies = new List<Currency__c>();
    private Integer[] statusCodes;
    private Date dateForRate;

    public CurrencyWorking(Integer[] codes, Date dateForRate){
        this.statusCodes = codes;
        this.dateForRate = dateForRate;
    }

    public CurrencyWorking(Integer[] codes){
        this.statusCodes = codes;
        this.dateForRate = Date.today();
    }

    public void start(){
        for(Integer i : this.statusCodes){
            restRequest(this.statusCodes[i]);
        }

        for(WorkWithCurrency.Rate rate : this.listOfRates){
            createCurrency(rate.Cur_Abbreviation, rate.Cur_OfficialRate);
        }

        insert this.listOfCurrencies;
    }

    public void restRequest(Integer code){

        try{
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('http://www.nbrb.by/API/ExRates/Rates/' + code + '?onDate=' + dateForRate.year() + '-' + dateForRate.month() + '-' + dateForRate.day() + '&');
            request.setMethod('GET');
            HttpResponse response = http.send(request);

            if(response.getStatusCode()!=200){
                System.debug('Page cannot be found.');
                System.debug('Status code: '+response.getStatusCode());
            }
            else{
                String jsonString = response.getBody();
                WorkWithCurrency.Rate rate = (WorkWithCurrency.Rate)JSON.deserialize(jsonString, WorkWithCurrency.Rate.class);

                this.listOfRates.add(rate);
            }
        } catch(CalloutException calloutException){
            calloutException.getMessage();
        }
    }

    public void createCurrency(String abbreviation, Decimal rate){

        Currency__c newCurrency = new Currency__c();

        newCurrency.Name = abbreviation + ' ' + String.valueOf(Date.today());
        newCurrency.Date__c = Date.today();
        newCurrency.Currency__c = abbreviation;
        newCurrency.Rate__c = rate;

        this.listOfCurrencies.add(newCurrency);
    }

    public class Rate{
        public String Cur_ID;
        public String Cur_Abbreviation;
        public String Cur_Scale;
        public String Cur_Name;
        public Decimal Cur_OfficialRate;
    }

}