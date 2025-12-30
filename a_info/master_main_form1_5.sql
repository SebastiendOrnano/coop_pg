SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion admin'         AS title,
    '/a_panels/panel_admin_5.sql' AS link;

select 
    'alert'           as component,
    'Avertissement'           as title,
    'alert-circle'    as icon,
    'red'             as color,
    TRUE              as important,
    TRUE              as dismissible,
    'Le choix du département "master" conditionne plusieurs éléments de l''écran d''accueil du site web : logo, titre de la page, contenu des rubriques du menu "about"' as description;

SELECT 
    'form'   AS component,
    'Département maître actuel' AS title,
    '' AS validate;
SELECT 
    'orga_dept_name' AS name,
    'Département maître' AS label,
    true as readonly,
    6 AS width,
    (select orga_dept_name from orga_dept where orga_dept_master = 'master') as value;
SELECT 
    'orga_name' AS name,
    'Organisation maître' AS label,
    true as readonly,
    6 AS width,
    (select orga_name from orga AS o
    LEFT JOIN (SELECT orga_id, orga_dept_id, orga_dept_master FROM orga_dept) as d
    ON o.orga_id = d.orga_id    
    where d.orga_dept_master = 'master') as value;


SELECT 
    'form'   AS component,
    'Étape 1 : choisir la structure mère' AS title,
    'Valider' AS validate,
    'clear' AS reset,
    '/a_info/master_main_form2_5.sql' AS action;

SELECT 
    'orga_id' AS name,
    'Choisir la structure mère' AS label,
    'select' AS type,
    6 AS width,
    TRUE AS searchable,
   'Saisissez quelques lettres du titre que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',orga_name,'value', orga_id))  AS options
    FROM orga;


