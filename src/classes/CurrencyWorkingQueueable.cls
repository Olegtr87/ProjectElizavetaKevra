public class CurrencyWorkingQueueable implements Queueable, Database.AllowsCallouts {

    private Date dateOfRate;
    private List<Integer> listOfCodes;

    public CurrencyWorkingQueueable(List<Integer> currencies, Date otherDate){
        this.dateOfRate = otherDate;
        this.listOfCodes = currencies;
    }

    public void execute(QueueableContext context) {
        CurrencyWorking currencyWork = new CurrencyWorking(this.listOfCodes, this.dateOfRate);
        currencyWork.start();
    }
}