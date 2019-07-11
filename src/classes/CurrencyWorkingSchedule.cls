public class CurrencyWorkingSchedule implements Schedulable{

    private Date dateOfRate;
    private List<Integer> listOfCurrencies;

    public CurrencyWorkingSchedule(Date otherDate, List<Integer> currencies){
        this.dateOfRate = otherDate;
        this.listOfCurrencies = currencies;
    }

    public CurrencyWorkingSchedule(List<Integer> currencies){
        this.dateOfRate = Date.today();
        this.listOfCurrencies = currencies;
    }

    public void execute(SchedulableContext SC) {
      System.enqueueJob(new CurrencyWorkingQueueable(this.listOfCurrencies, this.dateOfRate));
   }
}
