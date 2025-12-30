SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SELECT 
    'datagrid'              AS component,
    'Co-op Team'         AS title,
    'Composition de l''équipe du projet Co-op  
*Cliquez sur le portrait pour en savoir plus*' AS description_md;
SELECT 
    CONCAT (M.member_first_name,'  ',M.member_last_name)                                      AS title,
    CONCAT ('/b_orga_dept_members/orga_dept_member_profile_public.sql?member_id=',member_id)                  AS link,
    M.member_function                                                                       AS footer,
    ( SELECT 
        CASE 
            WHEN (m.member_picture_url IS NULL OR m.member_picture_url='') AND m.member_gender='M' THEN '/x_pictures_persons/silhouette_homme.png'
            WHEN (m.member_picture_url IS NULL OR m.member_picture_url='') AND m.member_gender='F' THEN '/x_pictures_persons/silouette_femme.png'
            WHEN (m.member_picture_url IS NULL OR m.member_picture_url='') AND m.member_gender='unknown' THEN '/x_pictures_persons/silhouette_iel.png'
            WHEN (m.member_picture_url IS NULL OR m.member_picture_url='') AND m.member_gender='' THEN '/x_pictures_persons/silhouette_iel.png'
            ELSE m.member_picture_url
        END 
    )   AS image_url
    FROM orga_dept_members as m 
    LEFT JOIN (select orga_dept_id, orga_dept_name, orga_dept_master FROM orga_dept) as d 
    ON m.orga_dept_id=d.orga_dept_id 
    WHERE m.member_category='team' AND M.member_status='active' AND d.orga_dept_master = 'master'  ;




