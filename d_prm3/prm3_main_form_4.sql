SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Superviseur'         as title,
    '/a_panels/panel_supervisor_4.sql' as link;
SELECT 
    'Gestion des groupements'            as title,
    '/d_prm3/prm3_main_display_4.sql'      as link;


SELECT 
    'form' as component,
    'Créer un groupement' as title,
    'Créer' as validate,
    '/d_prm3/prm3_main_create_0.sql' as action;

SELECT 
    'prm3_id' as name,
    'hidden' as type,
    $prm3_id as value,
    'id' as label;

SELECT
    'prm3_name' as name,
    'text' as type,  
    'Nom' as label,
    9 AS width,
    TRUE as required;

SELECT
    'prm3_summary' as name,
    'textarea' as type,  
    'Présentation du groupement' as label;

SELECT 
    'prm3_type'            as name,
    'Type de groupt'                 as label,
    'select'                       as type,
    3                              AS width,
    'Choisir un type dans la liste...'    as  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='prm3_type';

SELECT 
    'prm3_category'                as name,
    'Catégorie'                    as label,
    'select'                       as type,

    true                           as dropdown,
    true                           as create_new,
    3                              AS width,
    'Choisir une categorie dans la liste...'    as  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='prm3_category';

SELECT 
    'prm3_formal'            as name,
    'Formel-Informel'                 as label,
    'select'                       as type,
    3                              AS width,
    'Choisir un statut dans la liste...'    as  empty_option,
    '[{"label": "formel", "value": "formal"},
    {"label": "informel", "value": "informal"},
    {"label": "autre", "value": "N"}
    ]'  as options;


SELECT 
    'prm3_date_creation' as name,
    'Date de création'       as label,
    'date'                      as type,
    3                            AS width,
   (SELECT regex_value FROM regex WHERE regex_name='date')         as pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          as description;


















