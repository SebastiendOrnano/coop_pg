SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

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
    'Gestion Superviseur'         as title,
 '/a_panels/panel_supervisor_4.sql' as link;
SELECT 
    'Gestion des personnes physiques'            as title,
    '/d_prm2_sub_employees/prm2_sub_employee_main_display_4.sql?prm2_sub_id='||$prm2_sub_id  as link;


SELECT 
    'title' as component,
    (SELECT CONCAT (prm1_first_name, ' ',  prm1_last_name) FROM prm1 WHERE prm1_id = $prm1_id::INTEGER)  as contents,
    '1'    as level,
    TRUE as center;


SELECT 
    'form'            as component,
    'Info en tant qu''employé de l''entreprise' as title,
    '/d_prm2_sub_employees/prm2_sub_employee_main_update1_0.sql?employee_id='||$employee_id as action,
    'Actualiser' as validate,
    'Clear'      as reset;

SELECT 
    'employee_status'        as name,
    'select'                  as type,
    3                      AS width,
    (SELECT employee_status FROM prm2_sub_employees WHERE employee_id = $employee_id::INTEGER )  AS value,
    'Choisir un statut dans la liste...' AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT 
    'employee_title'        as name,
    'text'                  as type,
    3                      AS width,
    (SELECT employee_title FROM prm2_sub_employees WHERE employee_id = $employee_id::INTEGER )  AS value,
    'titre (dans l''entreprise)'                as label;

 SELECT 
    'employee_function'             as name,
    'Rôle (dans l''entreprise)'     as label,
    'text'                          as type,
    3                               AS width,
    (SELECT employee_function FROM prm2_sub_employees WHERE employee_id = $employee_id::INTEGER )  AS value;

SELECT 
    'employee_category'        as name,
    'Categorie (dans l''entreprise)'                as label,
    'text'                          as type,
    3                          AS width,
    (SELECT employee_category FROM prm2_sub_employees WHERE employee_id = $employee_id::INTEGER )  AS value;

SELECT 
    'employee_since' as name,
    'date'                as type,
    (SELECT employee_since FROM prm2_sub_employees WHERE employee_id = $employee_id::INTEGER )  AS value,
    3                     as width,
    'Employé depuis : (dans l''entreprise)'    as label;
