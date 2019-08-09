trigger TransactionTrigger on Transaction__c (after insert) {

    Transaction__c t = Trigger.new[0];
    System.debug(t);
    Account__c a = [SELECT Id, Amount__C FROM Account__c WHERE Id =: t.Account__c];
    Budget__c b = [SELECT Id, Spent__c FROM Budget__c WHERE Id =: t.Budget__c];
    System.debug(a);
    a.Amount__c = a.Amount__c - t.amount__c;
    
    b.Spent__c = b.Spent__c + t.Amount__c;
    
    update a;
    update b;
    // bulk
    List<Id> accountIds = new List<Id>();
    
    System.debug(Trigger.new);
    for(Transaction__c myt : Trigger.new) {
        accountIds.add(myt.Account__c);
    }
    System.debug(accountIds);
    
    //IDs From Account
    List<Account__c> accs = [SELECT Id, Amount__c FROM Account__c WHERE ID IN : accountIds];
    
    for (Transaction__c myt : Trigger.new) {
        for(Account__C a : accs) {
            System.debug(a);
            //Check Transaction ID = Account ID
            if (myt.Account__c == a.Id) {
                // this account matches this transaction
                 
            }
        }
    }
    
}