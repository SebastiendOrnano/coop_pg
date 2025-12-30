SET redirect_link1 = (
    SELECT
      CASE
           WHEN EXISTS 
           (
                SELECT 1
                FROM prm2_sub_employees
                WHERE employee_selected = true
            ) 
            THEN ''
            ELSE '/d_prm2_sub_employees/prm2_sub_employee_select_alert0_.sql?prm2_sub_id='||$prm2_sub_id
        END
);

SELECT 'redirect' AS component,
$redirect_link1 AS link
WHERE $redirect_link1 != '' OR $redirect1 IS NOT NULL;



SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

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
    '/d_prm2_sub_employees/prm2_sub_employee_select_display_4.sql?prm2_sub_id='||$prm2_sub_id||'&prm2_id='||$prm2_id  as link;

SELECT 
    'form' as component,
    'Actualiser le profil d''une sélection d''employés ' as title,
    'Actualiser' as validate,
   'Clear' as reset,
    '/d_prm2_sub_employees/prm2_sub_employee_select_update_0.sql?prm2_sub_id='||$prm2_sub_id as action;

SELECT 
    'employee_title'        as name,
    'text'                  as type,
    3                      AS width,
    (SELECT employee_title FROM prm2_sub_employees WHERE prm1_id = $prm1_id::INTEGER )  AS value,
    'titre (dans l''entreprise)'                as label;

 SELECT 
    'employee_function'        as name,
    'Rôle (dans l''entreprise)'                     as label,
    'select'                   as type,
    3                          AS width,
    (SELECT employee_function FROM prm2_sub_employees WHERE prm1_id = $prm1_id::INTEGER )  AS value,
    'Choisir un rôle...'       as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='employee_function';


SELECT 
    'employee_category'        as name,
    'Categorie (dans l''entreprise)'                as label,
    'select'                   as type,
    3                          AS width,
    (SELECT employee_category FROM prm2_sub_employees WHERE prm1_id = $prm1_id::INTEGER )  AS value,
    'Choisir une categorie...' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='employee_category';

SELECT 
    'employee_since' as name,
    'date'                as type,
    3                     as width,
    (SELECT employee_since FROM prm2_sub_employees WHERE prm1_id = $prm1_id::INTEGER )  AS value,
    'Employé depuis : (dans l''entreprise)'    as label;

SELECT 
    'employee_status'       as name,
    'Actif-Inactif (dans l''entreprise)'         as label,
    'select'                as type,
    3                       AS width,
    (SELECT employee_status FROM prm2_sub_employees WHERE prm1_id = $prm1_id::INTEGER )  AS value,
    'Choisir un statut...'  as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';



