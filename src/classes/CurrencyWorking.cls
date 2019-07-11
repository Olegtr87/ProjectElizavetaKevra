public class CurrencyWorking {

    private List<CurrencyWorking.Rate> listOfRates = new List<CurrencyWorking.Rate>();
    private List<Currency__c> listOfCurrencies = new List<Currency__c>();
    private List<Integer> statusCodes;
    private Date dateForRate;
    private String nameOfMetadataType;

    public CurrencyWorking(List<Integer> codes, Date dateForRate, String metadataType){
        this.statusCodes = codes;
        this.dateForRate = dateForRate;
        this.nameOfMetadataType = metadataType;
    }

    public void start(){
        for(Integer count = 0; count < this.statusCodes.size(); count++){
            restRequest(this.statusCodes.get(count));
        }

        for(CurrencyWorking.Rate rate : this.listOfRates){
            createCurrency(rate.Cur_Abbreviation, rate.Cur_OfficialRate);
        }

        insert this.listOfCurrencies;
    }

    public void restRequest(Integer code){

        try{
            Http http = new Http();
            HttpRequest request = new HttpRequest();

			request.setEndpoint(CurrencyManager.getURL(this.nameOfMetadataType) + '/' + code + '?onDate=' + dateForRate.year()
                                + '-' + dateForRate.month() + '-' + dateForRate.day() + '&');
            request.setMethod('GET');
            HttpResponse response = http.send(request);

            if(response.getStatusCode()!=200){
                System.debug('Page cannot be found.');
                System.debug('Status code: '+response.getStatusCode());
            }
            else{
                String jsonString = response.getBody();
                CurrencyWorking.Rate rate = (CurrencyWorking.Rate)JSON.deserialize(jsonString, CurrencyWorking.Rate.class);

                this.listOfRates.add(rate);
            }
        } catch(CalloutException calloutException){
            calloutException.getMessage();
        }
    }

    public void createCurrency(String abbreviation, Decimal rate){

        Currency__c newCurrency = new Currency__c();

        newCurrency.Name = abbreviation + ' ' + String.valueOf(this.dateForRate);
        newCurrency.Date__c = this.dateForRate;
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
