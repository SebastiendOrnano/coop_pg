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
    'Actualiser un choix' AS title,
    'Actualiser' AS validate,
    '/a_choices/choice_main_update_0.sql?choice_id='||$choice_id AS action;

SELECT
    'choice_label' AS name,
    'text' AS type,  
    'Nom' AS label,
    3 AS width,
    (SELECT choice_label FROM choices_items WHERE choice_id=$choice_id::INTEGER ) AS value,
    TRUE AS required;

SELECT 
    'choice_value'            AS name,
    'text' AS type,  
    'Valeur' AS label,
    3 AS width,
    (SELECT choice_value FROM choices_items WHERE choice_id=$choice_id::INTEGER ) AS value,
    TRUE AS required;

SELECT 
    'choice_category_id'                    AS name,
    'Catégorie'                             AS label,
    'select'                                AS type,
    (SELECT choice_category_id FROM choices_items WHERE choice_id=$choice_id::INTEGER ) AS value,
    4                                       AS width,
    TRUE                                    AS required,
'Choisir une categorie dans la liste...'    AS  empty_option,
json_agg(JSON_BUILD_OBJECT(
    'label', choice_category_name,
    'value', choice_category_id
)) AS options
FROM choices_categories;

SELECT 
    'choice_status'            AS name,
    'Statut'                 AS label,
    'select'                 AS type,
    3 AS width,
    TRUE                     AS required,
    (SELECT choice_status  FROM choices_items WHERE choice_id = $choice_id::INTEGER ) AS value,
    'Choisir un statut dans la liste...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value)) AS options
    FROM choices_items AS i 
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories) AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE c.choice_category_name = 'status';




















