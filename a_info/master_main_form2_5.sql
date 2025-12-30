SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion admin'         AS title,
    '/a_panels/panel_admin_5.sql' AS link;



SELECT 
    'form' AS component,
    'Étape 2 : choix du département master pour le site web' AS title,
    'Créer' AS validate,
    'Clear' AS reset,
    '/a_info/master_main_create_0.sql' AS action;

SELECT 
    'orga_dept_id'           AS name,
    'Choix du département master pour le site web'      AS label,
    'select'                     AS type,
    8 AS width,
    TRUE as searchable,
    'Saisissez quelques lettres du nom que vous cherchez ou choississez dans la liste' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',CONCAT('(',orga_dept_rank,') ',orga_dept_name), 'value', orga_dept_id)) AS options
    FROM (
    SELECT orga_dept_name, orga_dept_id, orga_dept_rank
    FROM orga_dept 
    WHERE orga_id=:orga_id::INTEGER
    ORDER BY orga_dept_name ASC
    );