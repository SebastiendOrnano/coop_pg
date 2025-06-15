SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET age = SELECT date_part('year', age(prm1_date_birthday))::INTEGER FROM prm1 WHERE prm1_id = $prm1_id::INTEGER;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Superviseur'         as title,
    '/a_panels/panel_supervisor_4.sql' as link;
SELECT 
    'Gestion des personnes physiques'            as title,
    '/d_prm1/prm1_main_display_4.sql' as link;
SELECT 
    'datagrid'              as component;
SELECT 
    '/d_prm1/prm1_main_edit_4.sql?prm1_id='|| $prm1_id  as link,
    'Edit' as description,
     'file-download'                         as icon,
    'orange'                                  as color;

SELECT 
    'title' as component,
    (SELECT CONCAT (prm1_first_name, ' ',  prm1_last_name) FROM prm1 WHERE prm1_id = $prm1_id::INTEGER)  as contents,
    '1'    as level,
    TRUE as center;
   
SELECT 
    'form'            as component,
    'Info générales' as title,
    '' as validate;
   
SELECT 
    'prm1_category' as name,
    'readonly' as type,
    (SELECT prm1_category  FROM prm1 WHERE prm1_id = $prm1_id::INTEGER )  AS value,
    1 as width,
    TRUE as readonly,
    'catégorie' as label;

SELECT 
    'prm1_status' as name,
    'text' as type,
    (SELECT prm1_status  FROM prm1 WHERE prm1_id = $prm1_id::INTEGER )  AS value,
      TRUE as readonly,
    1 as width,
    'statut' as label;

SELECT 
    'prm1_gender' as name,
    'text' as type,
    (SELECT prm1_gender  FROM prm1 WHERE prm1_id = $prm1_id::INTEGER )  AS value,
      TRUE as readonly,
    1 as width,
    'genre' as label;

SELECT 
    'prm1_date_birthday' as name,
    'text' as type,
   'ans' as suffix,
    $age as value,
    TRUE as readonly,
    2 as width,
    'age' as label;

SELECT
    'prm1_first_name' as name,
    'text' as type,  
    'Prénom' as label,
      TRUE as readonly,
    6 as width,
    (SELECT prm1_first_name  FROM prm1 WHERE prm1_id = $prm1_id::INTEGER ) as value;

SELECT
    'prm1_last_name' as name,
    'text' as type,  
    'Nom' as label,
      TRUE as readonly,
    6 as width,
    (SELECT prm1_last_name FROM prm1 WHERE prm1_id = $prm1_id::INTEGER ) as value;

SELECT 
    'prm1_phone' as name,
    'Téléphone' as label,
    'text' as type, 
     TRUE as readonly,
    6 as width,
    (SELECT prm1_phone FROM prm1 WHERE prm1_id = $prm1_id::INTEGER ) as value;

SELECT 
    'prm1_email' as name,
    'Email' as label,
    'text' as type, 
    6 as width,
      TRUE as readonly,
    (SELECT prm1_email FROM prm1 WHERE prm1_id = $prm1_id::INTEGER ) as value;

SELECT 
    'prm1_function' as name,
    'text' as type,
    'fonction' as label,
    4 as width,
      TRUE as readonly,
    (SELECT prm1_function FROM prm1 WHERE prm1_id = $prm1_id::INTEGER ) as value;

SELECT 
     'foldable' as component;
SELECT 
   'Résumé' as title,
   'foldablemargin' as class,
  prm1_CV_short as description_md
 FROM prm1  WHERE prm1_id = $prm1_id::INTEGER ;

SELECT 
     'foldable' as component;
SELECT 
   'CV'as title,
   'foldablemargin' as class,
  prm1_CV_long as description_md
 FROM prm1  WHERE prm1_id = $prm1_id::INTEGER ;

