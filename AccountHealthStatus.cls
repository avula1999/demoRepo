public class AccountHealthStatus 
    {     
       public static String generateRandomToken(Integer length) 
    {
        String validChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+-=[]{}|;:,.<>?';
        String token = '';
        while (token.length() < length) 
        {
            Integer randomIndex = Math.mod(Math.abs(Crypto.getRandomInteger()), validChars.length());
            token += validChars.substring(randomIndex, randomIndex + 1);
        }
        return token;
    }
      public static void HealthStatus(List<Account>aclist,map<id,Account> oldmap)
    {
     List<Contact> contactsToUpdate=new List<Contact>();
        for(Account newAccount:aclist)
        {
            Account oldMap1=oldmap.get(newAccount.id);
            if(newAccount.Current_Health_Status__c !=oldMap1.Current_Health_Status__c)
            {
                List<Contact> relatedContacts=[Select Id From Contact Where AccountId=:newAccount.Id];
                for(Contact c:relatedContacts)
                {
                    c.Contact_Health_Status__c=newAccount.Current_Health_Status__c;
                    c.Health_Status_Updated_Date__c=System.Today();
                    c.Token_For_Checkup__c=c.id;
                    contactsToUpdate.add(c);                
                }
            }
        }
               if(!contactsToUpdate.isEmpty())
            {
                 update contactsToUpdate;
            }
        
       }
}