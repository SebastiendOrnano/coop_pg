SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET orga_id = SELECT orga_id FROM orga_dept WHERE orga_dept_id=$orga_dept_id::INTEGER;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
 '/a_panels/panel_supervisor_4.sql' AS link;
SELECT 
    'Gestion des membres'            AS title,
    '/b_orga_dept_members/orga_dept_member_main_display_4.sql?orga_dept_id='||$orga_dept_id AS link;

SELECT 
    'form' AS component,
    'Créer un membre de l''organisation' AS title,
    'Créer' AS validate,
   'Clear' AS reset,
    '/b_orga_dept_members/orga_dept_member_main_create_0.sql?orga_dept_id='||$orga_dept_id AS action;

SELECT
    'orga_name' AS name,
    TRUE AS readonly,
    'Nom de la structure mère (rappel)' AS label,
    6 AS width,
    (SELECT orga_name  FROM orga WHERE orga_id = $orga_id::INTEGER ) AS value;
SELECT
    'orga_dept_name' AS name,
    TRUE AS readonly,
    'Nom de la structure (rappel)' AS label,
    6 AS width,
    (SELECT orga_dept_name  FROM orga_dept WHERE orga_dept_id = $orga_dept_id::INTEGER ) AS value;

SELECT 
    'member_gender'        AS name,
    'Genre'               AS label,
    'select'                AS type,
    2                      AS width,
    'Choisir un genre...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='gender';

SELECT
    'member_first_name' AS name,
    'text' AS type,  
    'Prénom' AS label,
    5 AS width,
    'prénom de l''adhérent' AS placeholder;

SELECT
    'member_last_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    TRUE AS required,
    5 AS width,
    'Nom de famille de l''adhérent' AS placeholder;

 SELECT 
    'member_category'        AS name,
    'Categorie'               AS label,
    'select'                AS type,
    3                     AS width,
    'Choisir une categorie...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='member_category';

 SELECT 
    'member_status'        AS name,
    'Actif-Inactif'               AS label,
    'select'                AS type,
    3                      AS width,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT 
    'member_publish'        AS name,
    'Public/privé'               AS label,
    'select'                AS type,
    3                     AS width,
    'Profil public ou caché...' AS empty_option,
    '[
    {"label": "Public", "value": true},
    {"label": "Privé", "value": false}
    ]' AS options;

SELECT 
    'file' AS type, 
    'member_picture_url' AS name,
    'Photo à insérer' AS label,
    'image/*' AS accept;

SELECT 
    'member_phone' AS name,
    'Téléphone' AS label,
    'text' AS type, 
    4 AS width,
-- TRUE AS required,
   (SELECT regex_value FROM regex WHERE regex_name='phone')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='phone')          AS description;

SELECT 
    'member_email' AS name,
    'Email' AS label,
    'text' AS type, 
    8 AS width,
    TRUE AS required,
   (SELECT regex_value FROM regex WHERE regex_name='email')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='email')          AS description;

 SELECT 
    'member_date_birthday' AS name,
    'Date de naissance' AS label,
    'date'       AS type, 
    4 AS width,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          AS description;

 SELECT 
    'member_date_since' AS name,
    'Membre depuis' AS label,
    'date'       AS type, 
    4 AS width,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          AS description;

 SELECT 
    'member_date_last_subscription' AS name,
    'Dernière date cotisation' AS label,
    'date'       AS type,
    4 AS width,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          AS description;

SELECT 
    'member_function' AS name,
    'text' AS type,
    'fonction' AS label,
    'fonction ou rôle dans l''organisation' AS description,
    'directeur ou chargé de mission' AS placeholder,
     3 AS width;


SELECT 
    'hidden' AS type, 
    'member_picture_title' AS name,
    'portrait    de   ' ||(SELECT CONCAT ( member_first_name,'   ',member_last_name)  FROM orga_dept_members WHERE member_id = $member_id::INTEGER ) AS value,
    'Photo portrait ' AS label,
    'formats acceptés : jpg,jpeg,png' AS description,
    true AS required;

SELECT 
    'member_punchline' AS name,
    'text' AS type,
    'Punch line' AS label,
    '3 mots pour qualifier le membre' AS description,
(   SELECT member_punchline FROM orga_dept_members WHERE member_id = $member_id::INTEGER ) AS value;

SELECT 
    'member_cv_short' AS name,
    'textarea' AS type,
    'Short CV' AS label,
    'Résumé du parcours et des fonctions. Format Markdown (dans la liste générale des membres utilisez [preview] pour vérifier le balisage md)' AS description,
    (SELECT member_cv_short FROM orga_dept_members WHERE member_id = $member_id::INTEGER ) AS value;

SELECT 
    'member_cv_long' AS name,
    'textarea' AS type,
    'Long CV' AS label,
    'CV détaillé. Format Markdown (dans la liste générale des membres utilisez [preview] pour vérifier le balisage md)' AS description,
    (SELECT member_cv_long FROM orga_dept_members WHERE member_id = $member_id::INTEGER ) AS value;





