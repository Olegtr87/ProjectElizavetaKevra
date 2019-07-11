public class CurrencyWorkingQueueable implements Queueable, Database.AllowsCallouts {

    private Date dateOfRate;
    private List<Integer> listOfCodes;
    private String nameOfMetadataType;

    public CurrencyWorkingQueueable(List<Integer> currencies, Date otherDate, String metadataTypeName){
        this.dateOfRate = otherDate;
        this.listOfCodes = currencies;
        this.nameOfMetadataType = metadataTypeName;
    }

    public void execute(QueueableContext context) {
        CurrencyWorking currencyWork = new CurrencyWorking(this.listOfCodes, this.dateOfRate, this.nameOfMetadataType);
        currencyWork.start();
    }
}
