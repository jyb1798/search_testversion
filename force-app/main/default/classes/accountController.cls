public with sharing class accountController {
    @AuraEnabled(cacheable=true)
    public static list<Lead> getAccounts(Integer searchNumber, Integer scope){
        return [select id, Name, NumberOfEmployees, Title, Industry, LastTransferDate, SICCode__c, Email from Lead where SICCode__c Like : : '%' + searchkey + '%'];
}

    @AuraEnabled(cacheable=true)
    public static list<Contact> getContacts(string searchkey){
        return [select id, Name, Phone, Email, Birthdate, CleanStatus,  Title, Fax from Contact where Name Like : '%' + searchkey + '%'];
    }
}

