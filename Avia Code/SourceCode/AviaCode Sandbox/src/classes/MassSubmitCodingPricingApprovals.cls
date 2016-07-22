public with sharing class MassSubmitCodingPricingApprovals {
    
    Apexpages.Standardcontroller sc;    
    public list<Coding_Specs__c> lstCodingSpecs         {get ; set;}
    //Coding_Specs__c CodingSpecs                         {get ; set;}
    //Approval.Processresult result {get ; set;}
    public list<Id> lstWorkItemId                         {get ; set;}
    public Boolean isVisible                             {get ; set;}
    public list<User> lstUser                             {get ; set;}
    public string codingSpecsId                         {get ; set;}
    public list<ProcessInstance> lstprocessInstance     {get ; set;}
    
    
    
    
    public MassSubmitCodingPricingApprovals(ApexPages.StandardController controller ){
        Id OpportunityId = ApexPages.currentPage().getParameters().get('Id');        
        
        if(OpportunityId != null ){
        lstCodingSpecs = new list<Coding_Specs__c>();
        lstCodingSpecs = [select Id, 
                                Name,
                                Specialty__c,
                                Access__c,
                                Type_of_Coding__c,
                                Coder_Cost__c,
                                Contract_Revenue__c,
                                Revenue_Multiple__c,
                                Monthly_Revenue__c,
                                Approval_Stage__c
                            from Coding_Specs__c 
                        where Opportunity__c =: OpportunityId ];//And Approval_Stage__c =: 'Needs Approval'
        }
        submitRequest();        
    }
    
    public void submitRequest(){
    set<Id>    setTargetObjectId = new set<Id>();
        for(Coding_Specs__c objSpecs : lstCodingSpecs){    
            setTargetObjectId.add(objSpecs.Id);
        }
        system.debug('------------setTargetObjectId-------'+ setTargetObjectId);
        lstprocessInstance = new List<ProcessInstance>();
        lstprocessInstance = [Select Id ,Status From ProcessInstance WHERE TargetObjectId =: setTargetObjectId 
                                                And Status != 'Approved' 
                                                And Status != 'Rejected']; 
          
        system.debug('------------lstprocessInstance-------'+ lstprocessInstance);
        
  }
    
    public Pagereference SubmitForApproval(){
        //for(ProcessInstance objProcessInstance : lstprocessInstance){
            //system.debug('------------objProcessInstance.Status------'+objProcessInstance.Status);
            //if(objProcessInstance.Status != 'Approved' && objProcessInstance.Status != 'Rejected' && objProcessInstance.Status != 'Pending'){    
                //system.debug('------------objProcessInstance.Status------'+objProcessInstance.Status);    
                if(lstCodingSpecs != null && lstCodingSpecs.size() > 0){
                    for(Coding_Specs__c objSpecs : lstCodingSpecs){    
                        if(objSpecs.Approval_Stage__c == 'Needs Approval'){
                            system.debug('------------objSpecs.Approval_Stage__c-------'+ objSpecs.Approval_Stage__c);            
                
                            Approval.Processsubmitrequest approvalRequest = new Approval.Processsubmitrequest();
                            system.debug('------------approvalRequest-------'+ approvalRequest);
                            approvalRequest.setComments('Submitted Coding Pricing Rec for approval.');
                            approvalRequest.setObjectId(objSpecs.Id);
                            approvalRequest.setNextApproverIds(new ID[]{UserInfo.getUserId()});
                            system.debug('------------AfterapprovalRequest-------'+ approvalRequest);
                            
                            Approval.Processresult result = Approval.process(approvalRequest);
                            system.debug('------------result-------'+ result);
                            //lstWorkItemId = result.getNewWorkitemIds();
                            //system.debug('------------lstWorkItemId-------'+ lstWorkItemId);
                            System.assert(result.isSuccess());
                            
                            system.debug('------------Successresult-------'+ result.isSuccess());
                        }                        
                    }
                }
            //}
                
        //}
        //}        
    return null;    
    }    
    
    public Id getWorkItemId(Id targetObjectId)
        {
            Id retVal = null;
     
            for(ProcessInstanceWorkitem workItem  : [Select p.Id ,p.ActorId  from ProcessInstanceWorkitem p
                where   p.ProcessInstance.TargetObjectId =: targetObjectId ])
            {
                retVal  =  workItem.Id;
            }
            system.debug('------------retVal-------'+ retVal);
            return retVal;
        }        
        
        
    public void approvedRecord(){
        Approval.ProcessWorkitemRequest req2;
        Approval.ProcessResult result2;
        system.debug('------------lstprocessInstance-------'+ lstprocessInstance);
        if(lstprocessInstance != null && lstprocessInstance.size() > 0){
            system.debug('---------lstprocessInstance.size(-------'+ lstprocessInstance.size());
            for(ProcessInstance objProcessInstance : lstprocessInstance){
                
                if(objProcessInstance.Status == 'Pending'){
                    system.debug('--------objProcessInstance.Status------'+ objProcessInstance.Status);
                    req2 = new Approval.ProcessWorkitemRequest();
                    req2.setComments(' Approved request.');
                    req2.setAction('Approve');
                    //req2.setNextApproverIds(new Id[] {UserInfo.getUserId()});
                    system.debug('------------req2-------'+ req2);        
                    if(lstCodingSpecs != null && lstCodingSpecs.size() > 0){    
                        system.debug('---------lstCodingSpecs-----'+ lstCodingSpecs);    
                        system.debug('---------lstCodingSpecs.size()-----'+ lstCodingSpecs.size());
                        for(Coding_Specs__c obj : lstCodingSpecs){                
                                
                                system.debug('-----------getWorkItemId(obj.id)------'+ getWorkItemId(obj.id));    
                                Id workItemId = getWorkItemId(obj.id);    
                                system.debug('-----------workItemId------'+ workItemId);                                  
                                system.debug('------------Afterreq2-------'+ req2);  
                                if(workItemId != null){
                                    req2.setWorkitemId(workItemId);// Submit the request for approval        
                                    system.debug('------------req2-------'+ req2);
                                    
                                }
                                
                        }
                        
                        
                    }
                    system.debug('------------req2-------'+ req2);
                    result2 =  Approval.process(req2);
                                system.debug('------------result2-------'+ result2);
                                System.assert(result2.isSuccess());    
                }
                
            }
            
        }
         
    }            
    public void rejectRecord(){
        Approval.ProcessWorkitemRequest req5;
        if(lstprocessInstance != null && lstprocessInstance.size() > 0){
            for(ProcessInstance objProcessInstance : lstprocessInstance){
                if(objProcessInstance.Status != 'Rejected' && objProcessInstance.Status != 'Approved' ){
                    if(lstCodingSpecs != null && lstCodingSpecs.size() > 0){                    
                        for(Coding_Specs__c obj : lstCodingSpecs){
                                req5 = new Approval.ProcessWorkitemRequest();
                                req5.setComments('Rejected request');
                                req5.setAction('Reject');
                                //req.setNextApproverIds(new Id[] {UserInfo.getUserId()});
                                Id workItemId = getWorkItemId(obj.id);
                                if(workItemId != null){
                                    req5.setWorkitemId(workItemId);
                                     
                                }                                
                        }
                    }    
                }
            }
            Approval.ProcessResult rejectResult =  Approval.process(req5);
                                    system.debug('------------rejectResult-------'+ rejectResult);
                                    System.assert(rejectResult.isSuccess());
        }
            
    }
}