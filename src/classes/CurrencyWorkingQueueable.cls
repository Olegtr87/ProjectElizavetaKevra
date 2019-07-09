public class CurrencyWorkingQueueable implements Queueable, Database.AllowsCallouts {

    public void execute(QueueableContext context) {

        Integer[] codes = new Integer[]{145, 298, 292};
        CurrencyWorking currencies = new CurrencyWorking(codes);
        currencies.start();
    }
}
