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
    'Gestion des choix'            AS title,
    '/a_choices/choice_main_display_5.sql'      AS link;


SELECT 
    'form' AS component,
    'Créer un choix' AS title,
    'Créer' AS validate,
    '/a_choices/choice_main_create_0.sql' AS action;

SELECT
    'choice_label' AS name,
    'text' AS type,  
    'Nom' AS label,
    4 AS width,
    TRUE AS required;

SELECT 
    'choice_value'            AS name,
    'text' AS type,  
    'Valeur' AS label,
    4 AS width,
    TRUE AS required;

SELECT 
    'choice_category_id'            AS name,
    'Catégorie'                  AS label,
    'select'                       AS type,
    4                             AS width,
    TRUE AS required,
'Choisir une categorie dans la liste...'    AS  empty_option,
json_agg(JSON_BUILD_OBJECT(
    'label', choice_category_name,
    'value', choice_category_id
)ORDER BY choice_category_name  ASC) AS options
FROM choices_categories;




















