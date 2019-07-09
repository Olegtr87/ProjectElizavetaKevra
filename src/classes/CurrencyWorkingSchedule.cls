public class CurrencyWorkingSchedule implements Schedulable{

    public void execute(SchedulableContext SC) {

      System.enqueueJob(new CurrencyWorkingQueueable());
   }
}
