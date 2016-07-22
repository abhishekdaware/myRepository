public with sharing class Approval_Process {
    
    public String Id {get;set;}
    public String approvalObjCode  {get;set;}
    public String customerID  {get;set;}
    public String description  {get;set;}
    public String enteredByID  {get;set;}
    public String extRefID  {get;set;}
    public String lastUpdatedByID  {get;set;}
    public String name  {get;set;}
    public String securityRootID  {get;set;}
    public String securityRootObjCode  {get;set;}
    public Integer durationMinutes  {get;set;}
    public dateTime entryDate  {get;set;}
    public dateTime lastUpdateDate  {get;set;}
    public String[] approvalStatuses  {get;set;}
    public boolean isPrivate  {get;set;}

}