public class CurrencyWorkingSchedule implements Schedulable{

    private Date dateOfRate;
    private List<Integer> listOfCurrencies;
    private String nameOfMetadataType;

    public CurrencyWorkingSchedule(Date otherDate, List<Integer> currencies, String nameOfMetadata){
        this.dateOfRate = otherDate;
        this.listOfCurrencies = currencies;
        this.nameOfMetadataType = nameOfMetadata;
    }

    public CurrencyWorkingSchedule(List<Integer> currencies, String nameOfMetadata){
        this.dateOfRate = Date.today();
        this.listOfCurrencies = currencies;
        this.nameOfMetadataType = nameOfMetadata;
    }

    public void execute(SchedulableContext SC) {
      System.enqueueJob(new CurrencyWorkingQueueable(this.listOfCurrencies, this.dateOfRate, this.nameOfMetadataType));
   }
}
