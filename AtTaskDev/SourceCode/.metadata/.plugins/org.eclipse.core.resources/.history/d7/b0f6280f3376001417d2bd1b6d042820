@RestResource(urlMapping='/kyazmademo/account')
global with sharing class RESTest{

    @HttpGet
    global static List<Account> getAccount(){
        String id = RestContext.request.params.get('id');
        Account[] accs = null;
        if(id != null){
            accs = [SELECT Id, Name, Phone FROM Account WHERE id =:id];
        }else{
            accs = [SELECT Id, Name, Phone FROM Account];
        }
        return accs;
    }

    @HttpPost
    global static String createAccount(String companyName, String phone){
        Account a = new Account();
        a.Name = companyName;
        a.Phone = phone;
        insert a;
        //RestContext.response.StatusCode = 400;
        return a.Id;
    }
    
    global class accContact{
        Account a {get;set;}
        Contact c {get;set;}
    }
    
    global class idSet{
        String accountId {get;set;}
        String contactId {get;set;}
    }
    
    @HttpPut
    global static idSet accCon(accContact ac){
        upsert ac.a;
        upsert ac.c;
        idSet id = new idSet();
        id.accountId = ac.a.Id;
        ac.c.accountId = id.accountId;
        id.contactId = ac.c.Id;
        return id;
    }
    
    @HttpPatch
    global static idSet acc(idSet ids){
        idSet id2 = new idSet();
        id2.accountId = 'Test1';
        id2.contactId = 'Test2';
        return id2;
    }
}