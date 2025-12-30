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
    '/a_users/user_main_display_5.sql'        as link,
    'liste des utilisateurs'                  as title;
SELECT
    '/a_users/user_select_display_5.sql'        as link,
    'Sélection des utilisateurs'                  as title;



SELECT 
    'form'                                                      AS component,
    'Actualisation des données des utilisateurs sélectionnés'        AS title ,
    'Actualiser les données de la sélection'                    AS validate,
    'green'                                                     AS validate_color,
    '/a_users/user_select_update_0.sql'                     AS action,
    'Clear'                                                     AS reset;

SELECT 
    'user_gender'        AS name,
    'Genre'               AS label,
    'select'                AS type,
    3                      AS width,
    'Choisir un genre...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='gender';

SELECT 
    'user_status'        AS name,
    'Status'               AS label,
    'select'                AS type,
    3                      AS width,
    'Choisir un statut...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT 
    'user_role'            AS name,
    'Role'               AS label,
    'select'                AS type,
    3                      AS width,
    'Choisir un statut...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='user_role';

SELECT 
    'user_lang'            AS name,
    'Role'               AS label,
    'select'                AS type,
    3                      AS width,
    'Choisir une langue...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='lang';

SELECT 
    'user_group'                   AS name,
    'Permission Groupe'      AS label,
    'select'                     AS type,
    3                            AS width,
    (SELECT user_group FROM users WHERE user_id=$user_id::INTEGER ) AS value,
    'Choisir un role dans la liste...'    AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='user_group';

SELECT 
    'user_level'                   AS name,
    'Permission Données'      AS label,
    'select'                     AS type,
    3                            AS width,
    (SELECT user_level FROM users WHERE user_id=$user_id::INTEGER ) AS value,
    'Choisir un role dans la liste...'    AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='user_level';
