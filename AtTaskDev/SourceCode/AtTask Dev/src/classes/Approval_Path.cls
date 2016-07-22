public with sharing class Approval_Path {
    
    public String ID  {get;set;}
    public String approvalProcessID  {get;set;}
    public String customerID  {get;set;}
    public String durationUnit  {get;set;}
    public String rejectedStatus  {get;set;}
    public String rejectedStatusLabel  {get;set;}
    public String targetStatus  {get;set;}
    public String targetStatusLabel  {get;set;}
    public Integer durationMinutes  {get;set;}
    public boolean shouldCreateIssue  {get;set;}


}