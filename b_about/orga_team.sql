SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SELECT 
    'datagrid'              AS component,
    'Co-op Team'         AS title,
    'Composition de l''équipe du projet Co-op  
*Cliquez sur le portrait pour en savoir plus*' AS description_md;
SELECT 
    CONCAT (member_first_name,'  ',member_last_name)                                      AS title,
    CONCAT ('/b_members/member_profile_public.sql?member_id=',member_id)                  AS link,
    member_function                                                                       AS footer,
    ( SELECT 
        CASE 
            WHEN (member_picture_url IS NULL OR member_picture_url='') AND member_gender='M' THEN '/x_pictures_persons/silhouette_homme.png'
            WHEN (member_picture_url IS NULL OR member_picture_url='') AND member_gender='F' THEN '/x_pictures_persons/silouette_femme.png'
            WHEN (member_picture_url IS NULL OR member_picture_url='') AND member_gender='unknown' THEN '/x_pictures_persons/silhouette_iel.png'
            WHEN (member_picture_url IS NULL OR member_picture_url='') AND member_gender='' THEN '/x_pictures_persons/silhouette_iel.png'
            ELSE member_picture_url
        END 
    )   AS image_url
    FROM members WHERE member_category='team' AND member_status='active' AND orga_dept_id = '2' ;




