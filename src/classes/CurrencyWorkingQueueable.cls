public class CurrencyWorkingQueueable implements Queueable, Database.AllowsCallouts {
    
    public void execute(QueueableContext context) {
        CurrencyWorkingClass.start();
    }
}