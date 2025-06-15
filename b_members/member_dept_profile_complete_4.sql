SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET age = (SELECT EXTRACT(YEAR FROM AGE(CURRENT_DATE, member_date_birthday)) FROM members WHERE member_id = $member_id::INTEGER)::INTEGER;



SET orga_dept_id= SELECT orga_dept_id FROM members WHERE member_id=$member_id::INTEGER;

SELECT 
    'datagrid'              AS component,
    'panel_dept_profile'         AS id;
SELECT 

     '/b_orga_dept/orga_dept_member_main_display_4.sql?orga_dept_id='||$orga_dept_id     AS link,
    'Revenir à la liste générale'                                                 AS description,
    'user-plus'                                                                   AS icon,
     'yellow'                                                                     AS color;
SELECT 
 
   '/b_members/member_dept_edit_4.sql?member_id='|| $member_id  AS link,
    'Edit' AS description,
     'file-download'                         AS icon,
    'orange'                                  AS color;

SELECT 
    '/b_members/member_dept_profile_publish_0.sql?member_id='|| $member_id  AS link,
    'Publier le profil' AS description,
    'file-download'                         AS icon,
    'green'                                  AS color;

SELECT 
    'html' AS component,
    '<div  id="portait_img">' AS html;
SELECT 
    '<img  alt=".."  src="'||(SELECT member_picture_url FROM members WHERE member_id = $member_id::INTEGER)|| '" />' AS html;
SELECT 
    '</div>' AS html;

    

SELECT 
    'title' AS component,
    (SELECT CONCAT (member_first_name, ' ',  member_last_name) FROM members WHERE member_id = $member_id::INTEGER)  AS contents,
    '1'    AS level,
    TRUE AS center;
   
SELECT 
    'text'              AS component,
    TRUE AS center,
    (SELECT member_punchline FROM members WHERE member_id = $member_id::INTEGER) AS contents;

SELECT 
    'text'              AS component,
    TRUE AS center,
    (SELECT member_punchline FROM members WHERE member_id = $member_id::INTEGER) AS contents;

SELECT 
    'form'            AS component,
    'Info générales' AS title,
    '' AS validate;
   
SELECT 
    'member_category' AS name,
    'readonly' AS type,
    (SELECT member_category  FROM members WHERE member_id = $member_id::INTEGER )  AS value,
    1 AS width,
    TRUE AS readonly,
    'catégorie' AS label;

SELECT 
    'member_status' AS name,
    'text' AS type,
    (SELECT member_status  FROM members WHERE member_id = $member_id::INTEGER )  AS value,
      TRUE AS readonly,
    1 AS width,
    'statut' AS label;

SELECT 
    'member_gender' AS name,
    'text' AS type,
    (SELECT member_gender  FROM members WHERE member_id = $member_id::INTEGER )  AS value,
      TRUE AS readonly,
    1 AS width,
    'genre' AS label;

SELECT 
    'member_date_birthday' AS name,
    'text' AS type,
    $age  AS value,
    TRUE AS readonly,
    2 AS width,
    'age' AS label;

SELECT 
    'member_date_since' AS name,
    'text' AS type,
    (SELECT member_date_since  FROM members WHERE member_id = $member_id::INTEGER )  AS value,
    TRUE AS readonly,
    3 AS width,
    'membre depuis...' AS label;

SELECT 
    'member_date_last_ssubscription' AS name,
    'text' AS type,
    (SELECT member_date_last_subscription  FROM members WHERE member_id = $member_id::INTEGER )  AS value,
    TRUE AS readonly,
    3 AS width,
    'date dernière cotisation' AS label;

SELECT
    'member_first_name' AS name,
    'text' AS type,  
    'Prénom' AS label,
      TRUE AS readonly,
    6 AS width,
    (SELECT member_first_name  FROM members WHERE member_id = $member_id::INTEGER ) AS value;

SELECT
    'member_last_name' AS name,
    'text' AS type,  
    'Nom' AS label,
      TRUE AS readonly,
    6 AS width,
    (SELECT member_last_name FROM members WHERE member_id = $member_id::INTEGER ) AS value;

SELECT 
    'member_phone' AS name,
    'Téléphone' AS label,
    'text' AS type, 
     TRUE AS readonly,
    6 AS width,
    (SELECT member_phone FROM members WHERE member_id = $member_id::INTEGER ) AS value;

SELECT 
    'member_email' AS name,
    'Email' AS label,
    'text' AS type, 
    6 AS width,
      TRUE AS readonly,
    (SELECT member_email FROM members WHERE member_id = $member_id::INTEGER ) AS value;

SELECT 
    'orga_name' AS name,
    'text' AS type,
    'Organization mère' AS label,
    4 AS width,
    TRUE AS readonly,
    (SELECT orga_name FROM orga as o
    LEFT JOIN (select orga_dept_id, orga_id FROM orga_dept) as d
    ON o.orga_id=d.orga_id    
    LEFT JOIN (select orga_dept_id, member_id FROM members) as m
    ON d.orga_dept_id = m.orga_dept_id 
    WHERE m.member_id = $member_id::INTEGER ) AS value;

SELECT 
    'orga_dept_name' AS name,
    'text' AS type,
    'Organization dept' AS label,
    4 AS width,
      TRUE AS readonly,
    (SELECT orga_dept_name FROM orga_dept 
    LEFT JOIN members ON orga_dept.orga_dept_id = members.orga_dept_id 
    WHERE member_id = $member_id::INTEGER ) AS value;

SELECT 
    'member_function' AS name,
    'text' AS type,
    'fonction' AS label,
    4 AS width,
      TRUE AS readonly,
    (SELECT member_function FROM members WHERE member_id = $member_id::INTEGER ) AS value;

SELECT 
     'foldable' AS component;
SELECT 
   'Résumé' AS title,
   'foldablemargin' AS class,
  member_CV_short AS description_md
 FROM members  WHERE member_id = $member_id::INTEGER;

SELECT 
     'foldable' AS component;
SELECT 
   'CV'as title,
   'foldablemargin' AS class,
  member_CV_long AS description_md
 FROM members  WHERE member_id = $member_id::INTEGER;

