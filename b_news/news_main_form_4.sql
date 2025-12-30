SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
SELECT 
    'Gestion des news'            AS title,
    '/b_news/news_main_display_4.sql'      AS link;


SELECT 
    'form' AS component,
    'Créer une organization' AS title,
    'Créer' AS validate,
    '/b_news/news_main_create_0.sql' AS action;

SELECT
    'news_title'           AS name,
    'text'                 AS type,  
    'Titre de l''article'  AS label,
    12                      AS width,
    TRUE                   AS required;

 SELECT 
    'news_public_private'     AS name,
    'Public / Privé'      AS label,
    'select'                     AS type,
    3                            AS width,
    TRUE                          AS required,
    'Choisir un statut dans la liste...' AS  empty_option,
    '[{"label": "Public", "value": "public"},
    {"label": "Privé", "value": "private"}
    ]'  AS options;

 SELECT 
    'news_status'     AS name,
    'Statut de publication'      AS label,
    'select'                     AS type,
    3                            AS width,
    TRUE                          AS required,
    'Choisir un statut dans la liste...' AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT 
    'news_date'                AS name,
    'Date'                      AS label,
    'date'                      AS type,
    3                            AS width,
    TRUE                          AS required,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          AS description;

SELECT 
    'news_category'               AS name,
    'Catégorie'                   AS label,
    'select'                       AS type,
    3                              AS width,
    'Choisir une categorie dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='news_category';


SELECT
    'news_content'                 AS name,
    'textarea'                     AS type,  
    'Contenu de l''article'        AS label,
    'A saisir en format markdown' AS description,
    TRUE                           AS required;

SELECT 
    'file'                  AS type, 
    'news_img_url'          AS name,
    'Illustration'    AS label,
    'image/pdf,jpg,jpeg,png,gif'  AS accept;


