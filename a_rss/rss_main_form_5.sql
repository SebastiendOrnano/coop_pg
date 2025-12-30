SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Admin'                      AS title,
    '/a_panels/panel_admin_5.sql'        AS link;
SELECT 
    'Liste des processus'                  AS title,
    '/a_rss/rss_main_display_5.sql'        AS link;

SELECT 
    'title'   AS component,
    'Nouveau lien RSS' AS contents,
    3         AS level;

-- Form for replying to the topic
SELECT 'form'                      AS component,
    'Créer un lien RSS'            AS validate,
    'Clear'                        AS reset,
    '/a_rss/rss_main_create_0.sql' AS action;

SELECT 
    'rss_feed'                 AS name, 
    'text'                          AS type, 
    'Path + Nom du fichier'         AS label,
    TRUE                            AS required;

SELECT 
    'rss_title'                    AS name, 
    'text'                         AS type, 
    'Nom du lien'                  AS label,
    TRUE                           AS required;

SELECT 
    'rss_link'                    AS name, 
    'text'                        AS type, 
    'link'                        AS label,
    TRUE                          AS required;

SELECT 
    'rss_description'                   AS name, 
    'textarea'                          AS type, 
    'description'                      AS label;

SELECT
    'rss_category'       AS name,
    'select'                   AS type,  
    'Categorie du lien'   AS label,
    TRUE                     AS required,
    4                       AS width,
    TRUE                     AS searchable,
     'Choisir un rôle dans la liste...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value)) AS options
    FROM choices_items AS i 
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories) AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE c.choice_category_name = 'user_role';
SELECT
    'rss_status'       AS name,
    'select'                   AS type,  
    'Statut du lien'   AS label,
    TRUE                     AS required,
    4                        AS width,
    'Choisir un statut dans la liste...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value)) AS options
    FROM choices_items AS i 
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories) AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE c.choice_category_name = 'status';
SELECT 
    'rss_item_title'                    AS name, 
    'text'                         AS type, 
    'Item :Nom du lien'              AS label,
    TRUE                           AS required;

SELECT 
    'rss_item_link'                    AS name, 
    'text'                        AS type, 
    'Item : link'                        AS label,
    TRUE                           AS required;

SELECT 
    'rss_item_table'              AS name, 
    'text'                        AS type, 
    'Item : table'                AS label,
    TRUE                          AS required;

SELECT 
    'rss_item_description'                   AS name, 
    'textarea'                          AS type, 
    'Item : description'                      AS label;