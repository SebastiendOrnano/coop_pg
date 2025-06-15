SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET age = SELECT date_part('year', age(employee_since))::INTEGER FROM prm2_sub_employees WHERE employee_id = $employee_id::INTEGER;
SET prm2_sub_id = SELECT prm2_sub_id FROM prm2_sub_employees WHERE employee_id = $employee_id::INTEGER;
SET  prm2_id = SELECT prm2_id FROM prm2_sub WHERE prm2_sub_id = $prm2_sub_id::INTEGER;
SET  prm1_id = SELECT prm1_id FROM prm2_sub_employees WHERE employee_id = $employee_id::INTEGER;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion éditeur'         as title,
    '/a_panels/panel_editor_3.sql' as link;
 SELECT 
    'Gestion du département'            as title,
    '/d_prm2_sub/prm2_sub_main_display_3.sql?prm2_id='||$prm2_id  as link;
SELECT 
    'Gestion des employés'            as title,
    '/d_prm2_sub_employees/prm2_sub_employee_main_display_3.sql?prm2_sub_id='||$prm2_sub_id  as link;  

SELECT 
    'title' as component,
    (SELECT CONCAT (prm1_first_name, ' ',  prm1_last_name) FROM prm1 WHERE prm1_id = $prm1_id::INTEGER)  as contents,
    '1'    as level,
    TRUE as center;

SELECT 
    'form'            as component,
    'Info en tant qu''employé de l''entreprise' as title,
    '' as validate;

SELECT 
    'employee_title'        as name,
    'text'                  as type,
    3                      AS width,
     TRUE as readonly,
    (SELECT employee_title FROM prm2_sub_employees WHERE employee_id = $employee_id::INTEGER )  AS value,
    'titre (dans l''entreprise)'                as label;

 SELECT 
    'employee_function'             as name,
    'Rôle (dans l''entreprise)'     as label,
    'text'                          as type,
    3                               AS width,
    TRUE                            as readonly,
    (SELECT employee_function FROM prm2_sub_employees WHERE employee_id = $employee_id::INTEGER )  AS value;

SELECT 
    'employee_category'        as name,
    'Categorie (dans l''entreprise)'                as label,
    'text'                          as type,
    3                          AS width,
     TRUE as readonly,
    (SELECT employee_category FROM prm2_sub_employees WHERE employee_id = $employee_id::INTEGER )  AS value;

SELECT 
    'employee_since' as name,
    'date'                as type,
    (SELECT employee_since FROM prm2_sub_employees WHERE employee_id = $employee_id::INTEGER )  AS value,
    3                     as width,
     TRUE as readonly,
    'Employé depuis : (dans l''entreprise)'    as label;


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
    $age  as value,
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
 FROM prm1  WHERE prm1_id = $prm1_id::INTEGER;

SELECT 
     'foldable' as component;
SELECT 
   'CV'as title,
   'foldablemargin' as class,
  prm1_CV_long as description_md
 FROM prm1  WHERE prm1_id = $prm1_id::INTEGER;

