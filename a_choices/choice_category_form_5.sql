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
    'Gestion des categories'            AS title,
    '/a_choices/choice_category_display_5.sql'      AS link;


SELECT 
    'form' AS component,
    'Créer une categorie de choix' AS title,
    'Créer' AS validate,
    '/a_choices/choice_category_create_0.sql' AS action;


SELECT
'choice_category_name' AS name,
'text' AS type,  
'Nom de la categorie' AS label,
 4 AS width,
TRUE AS required;

SELECT
'choice_category_summary' AS name,
'text' AS type,  
'Description de la categorie' AS label,
 8 AS width;


