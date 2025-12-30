SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET prm2_id= SELECT prm2_id FROM prm2_sub WHERE prm2_sub_id = $prm2_sub_id::INTEGER;

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
    'title'     as component,
    'Structure employeuse'    as contents,
    3           as level;

SELECT 
    'form' as component,
    '' as validate;
SELECT 
    'prm2_id' as name,
    'hidden' as type,
    $prm2_id as value,
    'id' as label;
SELECT 
    'prm2_sub_id' as name,
    'hidden' as type,
    $prm2_sub_id as value,
    'id' as label;
SELECT
    'prm2_sub_name' as name,
    TRUE as readonly,
    'Nom de la filiale ou du département' as label,
     6 as width,
    (SELECT prm2_sub_name  FROM prm2_sub WHERE prm2_sub_id = $prm2_sub_id::INTEGER ) as value;
SELECT
    'prm2_name' as name,
    'text' as type,
    TRUE as readonly, 
    'Nom de la organisation mère' as label,
    6 as width,
    (SELECT prm2_name  FROM prm2 WHERE prm2_id = $prm2_id::INTEGER ) as value;

SELECT 
    'alert'     as component,
    'Création d''un nouvel employé' as title,
     TRUE              as important,
    TRUE              as dismissible,
'Si vous ne trouvez pas le nom de l''employé(e) dans la liste, il faut alors créer un profil complet' as description_md,
'red' as color;

SELECT  
    'button' as component;
SELECT
    '/d_prm2_sub_employees/prm2_sub_employee_main_form2_3.sql?prm2_sub_id='||$prm2_sub_id             as link,
    'Créer le profil complet du nouvel employé'                            as title,
    'user-plus'                                          as icon,
    'green'                                              as color;

SELECT 
    'title'   as component,
    'Ajouter un employé' as contents,
    3         as level;

SELECT 
    'form'      AS component,
    'Ajouter un employé' as validate,
    '/d_prm2_sub_employees/prm2_sub_employee_main_attach_0.sql?prm2_sub_id='||$prm2_sub_id AS action;

SELECT 
   'prm1_id' as name,
    'Nom de l''empoyé' as label,
    'select' as type,
    12 AS width,
    TRUE as searchable,
    'Saisissez quelques lettres du nom que vous cherchez ou choississez dans la liste' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.prm1_last_name || '   ' || i.prm1_first_name, 'value', i.prm1_id)ORDER BY I.prm1_last_name ASC, I.prm1_first_name ASC) AS options
    FROM prm1 AS i
    LEFT OUTER JOIN  (SELECT prm1_id FROM prm2_sub_employees) AS t
    ON i.prm1_id = t.prm1_id
    WHERE t.prm1_id IS NULL;



SELECT 
    'employee_title'        as name,
    'text'                  as type,
    3                      AS width,
    'titre (dans l''entreprise)'                as label;

 SELECT 
    'employee_function'            as name,
    'Rôle (dans l''entreprise)'    as label,
    'select'                       as type,
    3                              AS width,
    'Choisir un rôle...'           as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='employee_function';


SELECT 
    'employee_category'                 as name,
    'Categorie (dans l''entreprise)'    as label,
    'select'                            as type,
    3                                   AS width,
    'Choisir une categorie...'          as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='employee_category';

SELECT 
    'employee_date_since'                       as name,
    'date'                                      as type,
    3                                           as width,
    'Employé  (dans l''entreprise) depuis :'    as label;

