SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor.sql' AS link;
SELECT 
    'Gestion des docs d''une personne'            AS title,
    '/d_prm1_doc/prm1_doc_main_display_3.sql?prm1_id='||$prm1_id     AS link;
SELECT 
    'Sélection docs d''une personne'            AS title,
    '/d_prm1_doc/prm1_doc_select_display_3.sql?prm1_id='||$prm1_id     AS link;




SELECT 
    'alert'                     AS component,
    TRUE AS important,
    'Les modifications dans le formulaire seront appliquées à tous les documents sélectionnées !' AS description,
    'alert-triangle'            AS icon,
      TRUE                       AS dismissible,
    'yellow'                    AS color;

SELECT 
    'form' AS component,
    'Actualiser les métadonnées d''une série de documents' AS title,
    'Actualiser' AS validate,
    'Clear' AS reset,
    '/d_prm1_doc/prm1_doc_select_update_0.sql?prm1_id='||$prm1_id AS action

SELECT 
    'prm1_doc_selected' AS name,
    'hidden' AS type,
     true AS value,
    'prm1_doc_selected' AS label;

SELECT 
    'prm1_doc_author' AS name,
    'text' AS type,
    'Auteur(s)' AS label,
    6 AS width;

SELECT 
    'prm1_doc_keywords' AS name,
    'text' AS type,
    'Mots clés' AS label,
    'Séparez les mots par une virgule' AS description,
    6 AS width;

SELECT 
    'prm1_doc_status'         AS name,
    'Statut de publication'   AS label,
    'select'                  AS type,
    4                         AS width,
    'Choisir un statut de pubication' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT 
    'prm1_doc_category'        AS name,
    'Catégorie'                 AS label,
    'select'                 AS type,
    4                       AS width,
    'Choisir une categorie...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_category';

SELECT 
    'prm1_doc_type'        AS name,
    'Type de document'   AS label,
    'select'                  AS type,
    4                         AS width,
    'Choisir un type...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_type';

 SELECT 
    'prm1_doc_date_publication' AS name,
    'Date de publication' AS label,
    'date'       AS type, 
    3 AS width,
    '^[0-9]{4}-(((0[13578]|(10|12))-(0[1-9]|[1-2][0-9]|3[0-1]))|(02-(0[1-9]|[1-2][0-9]))|((0[469]|11)-(0[1-9]|[1-2][0-9]|30)))$' AS pattern, 
    'format : DD-MM-YYYY' AS description;

 SELECT 
    'prm1_doc_date_period' AS name,
    'Période concernée' AS label,
    'text'       AS type,
    2 AS width,
    '^[0-9]{4}$' AS pattern, 
    'format : YYYY' AS description;

 SELECT 
    'prm1_doc_lang'        AS name,
    'Langue'               AS label,
    'select'                AS type,
    2                       AS width,
    'Choisir une langue...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='lang';
   
 SELECT 
    'prm1_doc_format'        AS name,
    'Format'                 AS label,
    'select'                 AS type,
    2                       AS width,
    'Choisir un format...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_format';
 

