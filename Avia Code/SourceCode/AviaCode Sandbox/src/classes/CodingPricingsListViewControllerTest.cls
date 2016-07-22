/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest(seeAllData = true)
private class CodingPricingsListViewControllerTest {

    public static Opportunity insert_Opportunity() {
        Account objAccount = new Account();
        objAccount.Name = 'test Account';
        database.insert(objAccount);            
        
         return( new Opportunity(Name = 'test Opportunity',
        AccountId = objAccount.id , StageName = 'Needs Assessment' ,CloseDate = Date.today().addDays(5)));
        
    }
    public static Coding_Specs__c insert_CodingSpecs(Id pOpportunityId) {
    	return (new Coding_Specs__c(Name = 'testPricing',
    	Opportunity__c = pOpportunityId , Specialty__c = 'Audiology' , Monthly_Quantity__c = 1 ,
    	Coder_Cost__c = 1 , Estimated_Charts_Per_Hour__c = 1 , Contract_Revenue__c = 1 ));
    	
    	
    }
        static testMethod void test_CodingPricingsListViewController() {
        	
         User objUser = new User(Alias = 'standt', Email='standarduser123@test.com', 
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                                LocaleSidKey='en_US', ProfileId = userInfo.getProfileId(), 
                                TimeZoneSidKey='America/Los_Angeles', UserName='standarduser123@test.com');
        //database.insert(objUser);   
        
        System.runAs(objUser){	
        Opportunity objOpportunity = insert_Opportunity();
        insert objOpportunity;
        
        Coding_Specs__c objCodingSpecs = insert_CodingSpecs(objOpportunity.Id);        
        objCodingSpecs.Type_of_Coding__c = 'Professional Fees';
        insert objCodingSpecs; 
        
        /*ProcessInstance objProcessInstance = new ProcessInstance();        
        insert objProcessInstance;*/        
        
        PageReference pageRef = Page.CodingPricingsListView;
        Test.setCurrentPage(pageRef);
        system.currentPageReference().getParameters().put('Id', objOpportunity.Id);
        ApexPages.StandardController sc = new ApexPages.StandardController(objOpportunity);
        CodingPricingsListViewController objController = new CodingPricingsListViewController(sc);             
        objController.CodingSpecsProfessionalFees();
        objController.getSelectedCodingSpecsRecords();
        objController.codingSpecs_PF_ToBeSelectList[0].isSelect = true;  
        objController.SubmitForApproval();
        objController.getWorkItemId(objCodingSpecs.Id);   
        objController.approvedRecord();
        objController.recallFromApproval();
        objController.rejectRecord();
        objController.save();
        objController.addNewRowforProf();
        objController.addNewRowforASC();
        objController.addNewRowforHosp();
        objController.addNewRowforAudit();       
        objController.cancel(); 
        
        }       
    }
    static testMethod void test_CodingPricingsListViewController1() {
    	User objUser = new User(Alias = 'standt', Email='standarduser123@test.com', 
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                                LocaleSidKey='en_US', ProfileId = userInfo.getProfileId(), 
                                TimeZoneSidKey='America/Los_Angeles', UserName='standarduser123@test.com');
        //database.insert(objUser);   
        
       // System.runAs(objUser){	
	        Opportunity objOpportunity = insert_Opportunity();
	        insert objOpportunity;
	        
	        Coding_Specs__c objCodingSpecs = insert_CodingSpecs(objOpportunity.Id);
	        objCodingSpecs.Type_of_Coding__c = 'Facility - ASC';
	        objCodingSpecs.Coder_Cost__c = null;
	        insert objCodingSpecs;
	        
	        PageReference pageRef = Page.CodingPricingsListView;
	        Test.setCurrentPage(pageRef);
	        system.currentPageReference().getParameters().put('Id', objOpportunity.Id);
	        ApexPages.StandardController sc = new ApexPages.StandardController(objOpportunity);
	        CodingPricingsListViewController objController = new CodingPricingsListViewController(sc);        
	        objController.CodingSpecsProfessionalFees();
	        objController.getSelectedCodingSpecsRecords();
	        objController.codingSpecs_FA_ToBeSelectList[0].isSelect = true;
	        objController.SubmitForApproval();
	        objController.getWorkItemId(objCodingSpecs.Id);   
	        objController.approvedRecord();
	        objController.recallFromApproval();
	        objController.rejectRecord();
	        objController.save();
	        objController.addNewRowforProf();
	        objController.addNewRowforASC();
	        objController.addNewRowforHosp();
	        objController.addNewRowforAudit();
	        objController.addNewRowforOther();  
	        objController.cancel();
	       
       // }
    }
    static testMethod void test_CodingPricingsListViewController2() {
    	User objUser = new User(Alias = 'standt', Email='standarduser123@test.com', 
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                                LocaleSidKey='en_US', ProfileId = userInfo.getProfileId(), 
                                TimeZoneSidKey='America/Los_Angeles', UserName='standarduser123@test.com');        
        
	        System.runAs(objUser){	
	        Opportunity objOpportunity = insert_Opportunity();
	        insert objOpportunity;
	        
	        Coding_Specs__c objCodingSpecs = insert_CodingSpecs(objOpportunity.Id);
	        objCodingSpecs.Type_of_Coding__c = 'Audit';
	        insert objCodingSpecs;
	        
	        PageReference pageRef = Page.CodingPricingsListView;
	        Test.setCurrentPage(pageRef);
	        system.currentPageReference().getParameters().put('Id', objOpportunity.Id);
	        ApexPages.StandardController sc = new ApexPages.StandardController(objOpportunity);
	        CodingPricingsListViewController objController = new CodingPricingsListViewController(sc);        
	        objController.CodingSpecsProfessionalFees();
	        objController.getSelectedCodingSpecsRecords();
	        objController.codingSpecs_A_ToBeSelectList[0].isSelect = true;
	        objController.SubmitForApproval();
	        objController.approvedRecord();
	        objController.recallFromApproval();
	        objController.getWorkItemId(objCodingSpecs.Id);   
	        objController.rejectRecord();
	        objController.addNewRowforProf();
	        objController.addNewRowforASC();
	        objController.addNewRowforHosp();
	        objController.addNewRowforAudit(); 
	        objController.addNewRowforOther(); 
	        objController.save();	       
	        objController.cancel();
        }
    }
    static testMethod void test_CodingPricingsListViewController3() {
    	User objUser = new User(Alias = 'standt', Email='standarduser123@test.com', 
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                                LocaleSidKey='en_US', ProfileId = userInfo.getProfileId(), 
                                TimeZoneSidKey='America/Los_Angeles', UserName='standarduser123@test.com');         
        
        System.runAs(objUser){	
	        Opportunity objOpportunity = insert_Opportunity();
	        insert objOpportunity;
	        
	        Coding_Specs__c objCodingSpecs = insert_CodingSpecs(objOpportunity.Id);
	        objCodingSpecs.Type_of_Coding__c = 'Facility - Hospital';
	        objCodingSpecs.Coder_Cost__c = null;
	        insert objCodingSpecs;
	        
	        PageReference pageRef = Page.CodingPricingsListView;
	        Test.setCurrentPage(pageRef);
	        system.currentPageReference().getParameters().put('Id', objOpportunity.Id);
	        ApexPages.StandardController sc = new ApexPages.StandardController(objOpportunity);
	        CodingPricingsListViewController objController = new CodingPricingsListViewController(sc);        
	        objController.CodingSpecsProfessionalFees();
	        objController.submitRequest();
	        objController.getSelectedCodingSpecsRecords(); 
	        objController.codingSpecs_FH_ToBeSelectList[0].isSelect = true;    
	        objController.SubmitForApproval();            
	        objController.approvedRecord();
	        objController.recallFromApproval();
	        objController.getWorkItemId(objCodingSpecs.Id);                
	        objController.rejectRecord();
	        objController.addNewRowforProf();
	        objController.addNewRowforASC();
	        objController.addNewRowforHosp();
	        objController.addNewRowforAudit(); 
	        objController.addNewRowforOther(); 
	        objController.save();	        
	        objController.cancel();
        }
	       
    }
    static testMethod void test_CodingPricingsListViewController4() {
    	User objUser = new User(Alias = 'standt', Email='standarduser123@test.com', 
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                                LocaleSidKey='en_US', ProfileId = userInfo.getProfileId(), 
                                TimeZoneSidKey='America/Los_Angeles', UserName='standarduser123@test.com');         
        
        System.runAs(objUser){	
	        Opportunity objOpportunity = insert_Opportunity();
	        insert objOpportunity;
	        
	        Coding_Specs__c objCodingSpecs = insert_CodingSpecs(objOpportunity.Id);
	        objCodingSpecs.Type_of_Coding__c = 'Other';
	        insert objCodingSpecs;
	        
	        PageReference pageRef = Page.CodingPricingsListView;
	        Test.setCurrentPage(pageRef);
	        system.currentPageReference().getParameters().put('Id', objOpportunity.Id);
	        ApexPages.StandardController sc = new ApexPages.StandardController(objOpportunity);
	        CodingPricingsListViewController objController = new CodingPricingsListViewController(sc);	        
	        objController.CodingSpecsProfessionalFees();
	        objController.submitRequest();
	        objController.getSelectedCodingSpecsRecords(); 
	        objController.codingSpecs_O_ToBeSelectList[0].isSelect = true;            
	        objController.SubmitForApproval();            
	        objController.approvedRecord();
	        objController.getWorkItemId(objCodingSpecs.Id);                
	        objController.rejectRecord();
	        objController.save();
	        objController.addNewRowforProf();
	        objController.addNewRowforASC();
	        objController.addNewRowforHosp();
	        objController.addNewRowforAudit(); 
	        objController.addNewRowforOther();
	        objController.cancel();
        }
	       
    }
}