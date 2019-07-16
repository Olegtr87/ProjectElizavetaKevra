@RestResource(urlMapping='/Currencies/*')
global class CurrencyRestManager {

    @HttpGet
    global static List<Currency__c> getCurrency(){
        
        String thisDate;
        if(RestContext.request.params.get('date') != null){
            thisDate = RestContext.request.params.get('date');
        } else { thisDate = ''; }

		String thisAbbreviation;
		if(RestContext.request.params.get('abbreviation') != null){
            thisAbbreviation = RestContext.request.params.get('abbreviation');
        } else { thisAbbreviation = ''; }

        return doGet(thisDate, thisAbbreviation);        
    }
    
    
    public static List<Currency__c> doGet(String thisDate, String thisAbbreviation){
        
        List<Currency__c> result;
        
		if(String.isEmpty(thisDate) && String.isEmpty(thisAbbreviation)){            
            result =  CurrencyManager.getListOfCurrency();
        }
        if(!String.isEmpty(thisDate) && String.isEmpty(thisAbbreviation)){            
            result =  CurrencyManager.getListOfCurrency(Date.valueOf(thisDate));
        }
        if(String.isEmpty(thisDate) && !String.isEmpty(thisAbbreviation)){            
            result =  CurrencyManager.getListOfCurrency(thisAbbreviation);
        }
        
        if(!String.isEmpty(thisDate) && !String.isEmpty(thisAbbreviation)){            
            result =  CurrencyManager.getListOfCurrency(Date.valueOf(thisDate), thisAbbreviation);
        }
        
        return result;
    } 
}
