create or replace procedure XXX_DELETION_PROCESS_SPR(P_ADV_REQ_ID NUMBER,
                                                     errbuf       OUT VARCHAR2,
                                                     retcode      OUT VARCHAR2) is
  V_ADV_REQ_ID number;
  l_appId      Number;
  l_respId     Number;
  l_user_Id    Number := Fnd_profile.Value('USER_ID');
  l_Org_Id     Number := Fnd_profile.Value('ORG_ID');

Begin

  /*Taking th RespId and ApplId*/
  Begin
    Select Application_id, Responsibility_id
      Into l_appId, l_respId
      From fnd_responsibility
     Where 1 = 1
       And Responsibility_Id = Fnd_profile.value('RESP_ID');
  Exception
    When Others Then
      l_appId  := 0;
      l_respId := 0;
  End;

  V_ADV_REQ_ID := P_ADV_REQ_ID;

  if V_ADV_REQ_ID != null then
  
    ----Delete header Record----------------------------------------------
    delete from xxap_advance_request x where adv_request_id = V_ADV_REQ_ID;
  
    ----Delete Detalis Records--------------------------------------------
    delete from xxpo_pr_details x where adv_request_id = V_ADV_REQ_ID;
  
    ----Delete invoices Records--------------------------------------------
    delete from xxap_supplier_payment x
     where adv_request_id = V_ADV_REQ_ID;
  
    DBMS_OUTPUT.put_line('Responsibility_id:' || l_respId);
    DBMS_OUTPUT.put_line('Application_id:' || l_appId);
    DBMS_OUTPUT.put_line('The deletion proceess has successfuly=' ||
                         V_ADV_REQ_ID);
  
  end if;

Exception
  When Others Then
    RETCODE := 2;
    errbuf  := 'Entered EXCEPTION block';
    DBMS_OUTPUT.put_line('There is no record found :');
End;
/
