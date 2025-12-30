--SET anonymous;
SET anonymous1=  SELECT(sqlpage.random_string(8));
SET anonymous2=  SELECT(sqlpage.random_string(8));
SET anonymous3=  SELECT(sqlpage.random_string(8));

SET orga_dept_id = SELECT orga_dept_id FROM orga_dept_members WHERE member_id=$member_id::INTEGER;

UPDATE  orga_dept_members 
SET  
   member_first_name=$anonymous1, 
   member_last_name=$anonymous2, 
   member_picture_url='/x_pictures_persons/silhouette_homme.png', 
   member_phone='000000',
   member_email=$anonymous3||'@noWHERE.com',
   member_status='archived',
   updated_at = CURRENT_TIMESTAMP
WHERE member_id=$member_id::INTEGER

RETURNING 
'redirect' AS component, 
'/b_orga_dept_members/orga_dept_member_main_display_4.sql?orga_dept_id='||$orga_dept_id::INTEGER AS link;

