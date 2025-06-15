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
    'Créer une categorie de choix' AS title,
    'Créer' AS validate,
    '/a_choices/regex_main_create_0.sql' AS action;

SELECT
'regex_name' AS name,
'text' AS type,  
'Nom de la règle' AS label,
 4 AS width,
TRUE AS required;

SELECT
'regex_value' AS name,
'text' AS type, 
TRUE AS required,
'Règle' AS label,
 8 AS width;

SELECT
'regex_description' AS name,
'text' AS type, 
TRUE AS required,
'Description' AS label,
 8 AS width;

SELECT
'regex_comment' AS name,
'text' AS type,  
'Commentaire sur la règle' AS label;;


