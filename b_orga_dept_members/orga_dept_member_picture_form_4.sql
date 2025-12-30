SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET orga_dept_id = SELECT orga_dept_id FROM orga_dept_members WHERE member_id=$member_id::INTEGER;

-- SELECT 'redirect' AS component, '/failure' AS link WHERE sqlpage.uploaded_file_path('file') is null;

SET picture = (
    SELECT 
        CASE 
            WHEN (member_picture_url IS NULL OR member_picture_url='') AND member_gender='M' THEN '/x_pictures_persons/silhouette_homme.png'
            WHEN (member_picture_url IS NULL OR member_picture_url='') AND member_gender='F' THEN '/x_pictures_persons/silouette_femme.png'
            WHEN (member_picture_url IS NULL OR member_picture_url='') AND member_gender='unknown' THEN '/x_pictures_persons/silhouette_iel.png'
            WHEN (member_picture_url IS NULL OR member_picture_url='') AND member_gender='' THEN '/x_pictures_persons/silhouette_iel.png'
            ELSE member_picture_url
        END 
    FROM orga_dept_members 
    WHERE member_id = $member_id::INTEGER
);

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
 '/a_panels/panel_supervisor_4.sql' AS link;
SELECT 
    'Gestion des membres'            AS title,
    '/b_orga_dept_members/orga_dept_member_main_display_4.sql?orga_dept_id='||$orga_dept_id AS link;

SELECT
    'carousel'              AS component,
  3             AS width,
    TRUE                    AS center,
    'member_change_picture' AS id;
SELECT
   320              AS height,
    $picture                AS image;
    

SELECT
 'form' AS component, 
 'insérer ou changer la photo  de : '|| (SELECT member_first_name ||'   '|| member_last_name  FROM orga_dept_members WHERE member_id = $member_id::INTEGER) AS title ,
 'insérer l''image' AS validate,
 'clear' AS reset, 
 '/b_orga_dept_members/orga_dept_member_picture_upload_0.sql?member_id=' ||$member_id AS action;

SELECT 
    'hidden' AS type, 
    'member_picture_title' AS name,
    'portrait    de   ' ||(SELECT CONCAT ( member_first_name,'   ',member_last_name)  FROM orga_dept_members WHERE member_id = $member_id::INTEGER ) AS value,
    'Nom actuel de la photo' AS label,
    true AS required;

SELECT 
    'file' AS type, 
    'member_picture_url' AS name,
    'Photo à insérer' AS label,
    TRUE AS required,
    'image/*' AS accept;

