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
            WHEN m.member_picture_url IS NULL OR  m.member_picture_url='' THEN '/x_pictures_persons/silhouette_homme.png'
            ELSE m.member_picture_url
        END 
 ) AS image,
 '['||m.member_first_name||'&nbsp; '||m.member_last_name ||'](/b_orga_dept_members/m.member_profile_public.sql?m.member_id='||m.member_id||')    
'||m.member_function AS description_md,
   '  ' AS title,
    320                       AS height
 
    FROM orga_dept_members as m 
    LEFT JOIN (select orga_dept_id, orga_dept_name, orga_dept_master FROM orga_dept) as d 
    ON m.orga_dept_id=d.orga_dept_id 
    WHERE m.member_category='govern' AND M.member_status='active' AND d.orga_dept_master = 'master'  ;
