SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Admin'            as title,
 '/a_panels/panel_admin_5.sql' as link;
 SELECT 
    'Retour Gestion des utilisateur actifs'         as title,
    '/a_users/user_main_display_5.sql'            as link;


SELECT
    'form'                                as component,
    'Droits de l''utilisateur'            as title,
    'Mettre à jour les droits de l''utilisateur' as validate,
    'green'                              as validate_color,
    '/a_users/user_main_update_0.sql?user_id='||$user_id as action,
    'Clear'                                as reset;

SELECT 
    'username'           AS name,
    'Nom d''utilisateur' AS label,
    TRUE                as readonly,
    12                  AS width,
  (SELECT username FROM users WHERE user_id=$user_id::INTEGER ) as value;

 SELECT 
    'user_gender'        as name,
    'Genre'               as label,
    'select'                as type,
    TRUE                as readonly,
    (SELECT user_gender FROM users WHERE user_id=$user_id::INTEGER ) as value,
    2                     AS width,
    'Choisir un genre...' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='gender';

SELECT 
    'user_first_name'    AS name,
    'Prénom'             AS label,
    TRUE                as readonly,
    4                   AS width,
  (SELECT username FROM users WHERE user_id=$user_id::INTEGER ) as value;

SELECT 
    'user_last_name'     AS name,
    'Nom de famille'     AS label,
    TRUE                as readonly,
    4                  AS width,
  (SELECT username FROM users WHERE user_id=$user_id::INTEGER ) as value;

SELECT 
    'user_short_cv'        as name,
    'CV de l''utilisateur' as label,
    'textarea'             as type,
     TRUE                  as readonly,
    12                     AS width,
 (SELECT user_short_cv FROM users WHERE user_id=$user_id::INTEGER ) as value;
 
SELECT 
    'user_role'                   as name,
    'Role'                       as label,
    'select'                     as type,
    3                            AS width,
    (SELECT user_role FROM users WHERE user_id=$user_id::INTEGER ) as value,
    'Choisir un role dans la liste...'    as  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='user_role';

SELECT 
    'user_group'                   as name,
    'Permission Groupe'      as label,
    'select'                     as type,
    3                            AS width,
    (SELECT user_group FROM users WHERE user_id=$user_id::INTEGER ) as value,
    'Choisir un role dans la liste...'    as  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='user_group';

SELECT 
    'user_level'                   as name,
    'Permission Données'      as label,
    'select'                     as type,
    3                            AS width,
    (SELECT user_level FROM users WHERE user_id=$user_id::INTEGER ) as value,
    'Choisir un role dans la liste...'    as  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='user_level';

SELECT 
    'user_status'                   as name,
    'Statut'      as label,
    'select'                     as type,
    3                            AS width,
    (SELECT user_status FROM users WHERE user_id=$user_id::INTEGER ) as value,
    'Choisir un role dans la liste...'    as  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

    
