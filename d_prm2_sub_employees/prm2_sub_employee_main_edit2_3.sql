SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET prm1_id = SELECT prm1_id FROM prm2_sub_employees WHERE employee_id=$employee_id::INTEGER;
SET prm2_sub_id = SELECT prm2_sub_id FROM prm2_sub_employees WHERE employee_id=$employee_id::INTEGER;
SET prm2_sub_name = SELECT prm2_sub_name FROM prm2_sub WHERE prm2_sub_id = $prm2_sub_id::INTEGER ;
SET prm2_id = SELECT prm2_id FROM prm2_sub WHERE prm2_sub_id = $prm2_sub_id::INTEGER;
SET prm2_name = SELECT prm2_name FROM prm2 WHERE prm2_id=$prm2_id::INTEGER;
SET compagny_name = CONCAT($prm2_name, '---',$prm2_sub_name);
SET employee_name = (SELECT CONCAT (prm1_first_name, ' ',  prm1_last_name) FROM prm1 WHERE prm1_id = $prm1_id::INTEGER) ;

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
    'form' as component,
    'Actualiser le profil général de : '||$employee_name as title,
    'Actualiser' as validate,
   'Clear' as reset,
    '/d_prm2_sub_employees/prm2_sub_employee_main_update_0.sql?employee_id='||$employee_id as action;

SELECT 
    'prm1_gender'        as name,
    'Genre'               as label,
    'select'                as type,
    2                      AS width,
    (SELECT prm1_gender  FROM prm1 WHERE prm1_id = $prm1_id::INTEGER )  AS value,
    'Choisir un genre...' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='gender';

SELECT
    'prm1_first_name' as name,
    'text' as type,  
    'Prénom' as label,
    5 AS width,
    (SELECT prm1_first_name  FROM prm1 WHERE prm1_id = $prm1_id::INTEGER )  AS value,
    'prénom' AS placeholder;

SELECT
    'prm1_last_name' as name,
    'text' as type,  
    'Nom' as label,
    TRUE as required,
    (SELECT prm1_last_name  FROM prm1 WHERE prm1_id = $prm1_id::INTEGER )  AS value,
    5 AS width,
    'Nom de famille ' AS placeholder;

SELECT 
    'prm1_category'        as name,
    'Categorie'               as label,
    'select'                as type,
    (SELECT prm1_category  FROM prm1 WHERE prm1_id = $prm1_id::INTEGER )  AS value,
    3                     AS width,
    'Choisir une categorie...' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='prm1_category';

 SELECT 
    'prm1_date_birthday' as name,
    'Date de naissance' as label,
    'date'       as type,
    (SELECT prm1_date_birthday  FROM prm1 WHERE prm1_id = $prm1_id::INTEGER )  AS value, 
    4 AS width,
(SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
(SELECT regex_description FROM regex WHERE regex_name='date')          AS description;

SELECT 
    'prm1_function' as name,
    'text' as type,
    'fonction' as label,
    (SELECT prm1_function FROM prm1 WHERE prm1_id = $prm1_id::INTEGER )  AS value, 
    'fonction ' as description,
     3 AS width;

SELECT 
    'prm1_phone' as name,
    'Téléphone' as label,
    'text' as type, 
    4 AS width,
    (SELECT prm1_phone  FROM prm1 WHERE prm1_id = $prm1_id::INTEGER )  AS value,
    '+33 6' AS placeholder, 
    (SELECT regex_value FROM regex WHERE regex_name='phone')         AS pattern,
    (SELECT regex_description FROM regex WHERE regex_name='phone')          AS description;

SELECT 
    'prm1_email' as name,
    'Email' as label,
    'text' as type, 
    8 AS width,
    true as required,
    (SELECT prm1_email  FROM prm1 WHERE prm1_id = $prm1_id::INTEGER )  AS value,
    (SELECT regex_value FROM regex WHERE regex_name='email')         AS pattern,
    (SELECT regex_description FROM regex WHERE regex_name='email')          AS description;

SELECT 
    'prm1_cv_short' as name,
    'textarea' as type,
    'Short CV' as label,
    'Résumé du parcours et des fonctions. Format Markdown (dans la liste générale utilisez [view] pour vérifier le balisage md)' as description,
    (SELECT prm1_cv_short FROM prm1 WHERE prm1_id = $prm1_id::INTEGER ) as value;

SELECT 
    'prm1_cv_long' as name,
    'textarea' as type,
    'Long CV' as label,
    'CV détaillé. Format Markdown (dans la liste générale utilisez [view] pour vérifier le balisage md)' as description,
    (SELECT prm1_cv_long FROM prm1 WHERE prm1_id = $prm1_id::INTEGER ) as value;

