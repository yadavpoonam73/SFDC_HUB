public class ExampleLA{

public string result;
public string orgname;
public string orgcountry;


    public void method1(){
    Organization orgDetails=[Select Id,Name,Country from Organization limit 1 ];
    Id orgId= orgDetails.Id;
    orgname= orgDetails.Name;
    orgcountry=orgDetails.Country;
    System.debug('##### ID: '+ orgId);
    System.debug('##### Name: '+ orgname);
    System.debug('##### ID: '+ orgcountry);
    PageReference pr= new PageReference('/'+orgId);
    System.debug('@@@@@@@ pr'+pr);
    String rawData=pr.getContent().tostring();
    System.debug('@@@@@@@@@@@ rawData :'  + rawData);
    String licrow='>Salesforce</th><td class=" dataCell  ">Active</td><td class=" dataCell  numericalColumn">';
    System.debug('@@@@@@@@@@@@ licrow :'+ licrow);
    Integer licLen= licrow.length();
    System.debug('@@@@@@@@@@@@@@@ liclength :'+licLen );
    Integer pos= rawData.indexof(licrow);
    System.debug('@@@@@@@@@@@@@@@@@@@@@ pos :'+ pos);
    if(-1 != pos){
     Integer licStart= pos+licLen;
     System.debug('@@@@@@@@@@@@@@@@@@@@@@@ licstart :'+ licStart);
     result= rawData.Substring(licstart,licstart+1);
     System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@ result :'+ result);
     }
      Decimal lic= Decimal.valueof(result);
     System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@ lic :'+ lic);
     Integer u=[Select count() from user where profile.userlicense.Name='Salesforce' and isactive=true ];
     System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ u :'+ u);
     Decimal usercount= Decimal.valueof(u);
   Integer  totalunused=(lic.intValue()-usercount.intvalue());
   
   
   
            
            
     System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ totalunused :'+ totalunused);
     if(totalunused<=5){
     System.debug('Sending Email');
     Messaging.SingleEmailMessage mail= new Messaging.SingleEmailMessage();
     String[]toadd=new String[]{'poonam.yadav@capgemini.com'};
     mail.setToAddresses(toadd);
     mail.setReplyTo('poonam.yadav@capgemini.com');
     mail.setSenderDisplayName('Salesforce License Notification');
     mail.setSubject(orgname+'Liscense count :'+ string.valueof(totalunused));
     mail.setBccSender(false);
     mail.setUseSignature(false);
     mail.setPlainTextBody('Liscense count:'+ string.valueof(totalunused));
     mail.setHtmlBody('Liscense Availibility Alert <br/>'+orgName+','+ orgcountry+'<br/>'+ 'License count' + string.valueof(totalunused) );
    List<Messaging.SendEmailResult> results= Messaging.SendEmail(new Messaging.Email[]{mail});
    System.debug('***************Email Sent'+results.get(0).isSuccess());
    }
    }
    }