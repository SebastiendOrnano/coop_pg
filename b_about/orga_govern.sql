SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;




SELECT 
    'title'   AS component,
    'L''équipe de gouvernance du projet' AS contents,

    TRUE      AS center;


SELECT 
    'carousel'     AS component,
    3   AS width,
    TRUE           AS center,
    'dot' AS indicators,
    TRUE           AS controls;
  
SELECT 
    (
    SELECT 
        CASE 
            WHEN member_picture_url IS NULL OR  member_picture_url='' THEN '/x_pictures_persons/silhouette_homme.png'
            ELSE member_picture_url
        END 
 ) AS image,
 '['||member_first_name||'&nbsp; '||member_last_name ||'](/b_members/member_profile_public.sql?member_id='||member_id||')    
'||member_function AS description_md,
   '  ' AS title,
    320                       AS height
 
FROM members WHERE member_category='govern' AND member_status='active' AND orga_dept_id = '2' ;