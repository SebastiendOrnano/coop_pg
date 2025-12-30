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
    'Gestion des règles'            AS title,
    '/a_choices/regex_main_display_5.sql'      AS link;


SELECT 
    'form' AS component,
    'Actualiser un choix' AS title,
    'Actualiser' AS validate,
    '/a_choices/regex_main_update_0.sql?regex_id='||$regex_id::INTEGER  AS action;

SELECT
    'regex_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    3 AS width,
    (SELECT regex_name FROM regex WHERE regex_id= $regex_id::INTEGER ) AS value,
    TRUE AS required;

SELECT 
    'regex_value'            AS name,
    'text' AS type,  
    'Valeur' AS label,
    9 AS width,
    (SELECT regex_value FROM regex WHERE regex_id=$regex_id::INTEGER ) AS value,
    TRUE AS required;

SELECT 
    'regex_description'                    AS name,
    'Description'                             AS label,
    'text'                                AS type,
    (SELECT regex_description FROM regex WHERE regex_id=$regex_id::INTEGER ) AS value;

SELECT 
    'regex_comment'                    AS name,
    'Commentaire'                             AS label,
    'text'                                AS type,
    (SELECT regex_comment FROM regex WHERE regex_id=$regex_id::INTEGER ) AS value;

 SELECT 
    'regex_status'            AS name,
    'Statut'                 AS label,
    'select'                 AS type,
    3 AS width,
    TRUE                     AS required,
    (SELECT regex_status FROM regex WHERE regex_id = $regex_id::INTEGER ) AS value,
    'Choisir un statut dans la liste...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value)) AS options
    FROM choices_items AS i 
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories) AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE c.choice_category_name = 'status';