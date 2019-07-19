public class GraphController {

    @auraEnabled
    public List<LineChartVar> myLineChartVarList;

    public class LineChartVar {
        string dateForLabel;
        decimal usd;
        decimal eur;
        decimal rub;

        public LineChartVar(string someDate, decimal usd1, decimal eur1, decimal rub1){
            this.dateForLabel = someDate;
            this.usd = usd1;
            this.eur = eur1;
            this.rub = rub1;
        }
    }

    @auraEnabled
    public static String getLineChartMap(){

        List<Currency__c> usd = [SELECT Rate__c, Date__c FROM Currency__c WHERE Currency__c =: 'USD'];
        List<Currency__c> eur = [SELECT Rate__c FROM Currency__c WHERE Currency__c =: 'EUR'];
        List<Currency__c> rub = [SELECT Rate__c FROM Currency__c WHERE Currency__c =: 'RUB'];

        List<LineChartVar> myLineChartVarList = new List<LineChartVar>();
        Map<Date, LineChartVar> mapToCompare = new Map<Date, LineChartVar>();

        for(integer i = 0; i < usd.size(); i++){
            myLineChartVarList.add(new LineChartVar(String.valueOf(usd.get(i).Date__c), usd.get(i).Rate__c, eur.get(i).Rate__c, rub.get(i).Rate__c));
            mapToCompare.put(usd.get(i).Date__c, myLineChartVarList.get(i));
        }

        return JSON.Serialize(sortList(mapToCompare));
    }

    public static List<LineChartVar> sortList(Map<Date, LineChartVar> mapToCompare){

        List<LineChartVar> newLineChartVarList = new List<LineChartVar>();

        List<Date> dateToCompare = new List<Date>();
        for(Date myDate : mapToCompare.keySet()){
            dateToCompare.add(myDate);
        }
        dateToCompare.sort();

        for(Date thisDate : dateToCompare)
            for(Date datty : mapToCompare.keySet())
                if(thisDate == datty){
                    newLineChartVarList.add(mapToCompare.get(datty));
                }

        return newLineChartVarList;
    }
}