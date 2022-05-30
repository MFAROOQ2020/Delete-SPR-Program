select distinct x.document_name,
                x.adv_request_id,
                x.org_id,
                X.REQUESTER,
                x.created_by
  from xxap_advance_request x where x.requester like '%ORACLE%'
  
  
  
  select Fnd_profile.Value('USER_ID') from dual;


XXX_DELETION_PROCESS_SPR
