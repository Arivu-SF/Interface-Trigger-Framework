/**
 * @description  This class runs the appropriate methods on the trigger handler based on the current trigger context.
 */
public class TriggerDispatcher {
    /*
      Call this method from your trigger, passing in an instance of a trigger handler which implements ITriggerHandler.
      This method will fire the appropriate methods on the handler depending on the trigger context.
    */
    public static void run(ITriggerHandler handler, System.TriggerOperation triggerEvent)
    {
      // Check to see if the trigger has been disabled. If it has, return
      if(handler.isDisabled()){
        return;
      }
      // Detect the current trigger context and fire the relevant methods on the trigger handler:
      switch on triggerEvent {
        when BEFORE_INSERT {
          handler.beforeInsert(Trigger.new);
        } when BEFORE_UPDATE {
          handler.beforeUpdate(Trigger.newMap, Trigger.oldMap);
        } when BEFORE_DELETE {
          handler.beforeDelete(Trigger.oldMap);
        } when AFTER_INSERT {
          handler.afterInsert(Trigger.newMap);
        } when AFTER_UPDATE {
          handler.afterUpdate(Trigger.newMap, Trigger.oldMap);
        } when AFTER_DELETE {
          handler.afterDelete(Trigger.oldMap);
        } when AFTER_UNDELETE {
          handler.afterUndelete(Trigger.oldMap);
        }
      }  
    }
  }