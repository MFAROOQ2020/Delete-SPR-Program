select last_connect,
       usr.user_name,
       icx.user_id,
       per.FULL_NAME FULL_NAME,
       resp.responsibility_key,
       function_type
  from apps.icx_sessions  icx,
       PER_PEOPLE_F       per,
       fnd_user           usr,
       fnd_responsibility resp
 where usr.user_id = icx.user_id
   and usr.EMPLOYEE_ID = per.PERSON_ID
   and icx.responsibility_id = resp.responsibility_id
   and last_connect >
       sysdate -
       nvl(FND_PROFILE.VALUE('ICX_SESSION_TIMEOUT'), 30) / 60 / 24
   and disabled_flag != 'Y'
   and pseudo_flag = 'N';
