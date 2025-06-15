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
    'Gestion des membres'            AS title,
    '/b_members/member_main_display_4.sql' AS link;

SELECT 
    'form' AS component,
    'Créer un membre de l''organisation' AS title,
    'Créer' AS validate,
   'Clear' AS reset,
    '/b_members/member_main_create_0.sql' AS action;

SELECT 
    'member_gender'        AS name,
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
    'member_first_name' AS name,
    'text' AS type,  
    'Prénom' AS label,
    6 AS width,
    'prénom de l''adhérent' AS placeholder;

SELECT
    'member_last_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    TRUE AS required,
    6 AS width,
    'Nom de famille de l''adhérent' AS placeholder;

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
    'portrait    de   ' ||(SELECT CONCAT ( member_first_name,'   ',member_last_name)  FROM members WHERE member_id = $member_id::INTEGER ) AS value,
    'Photo portrait ' AS label,
    'formats acceptés : jpg,jpeg,png' AS description,
    true AS required;

SELECT 
    'member_punchline' AS name,
    'text' AS type,
    'Punch line' AS label,
    '3 mots pour qualifier le membre' AS description,
(   SELECT member_punchline FROM members WHERE member_id = $member_id::INTEGER ) AS value;

SELECT 
    'member_cv_short' AS name,
    'textarea' AS type,
    'Short CV' AS label,
    'Résumé du parcours et des fonctions. Format Markdown (dans la liste générale des membres utilisez [preview] pour vérifier le balisage md)' AS description,
    (SELECT member_cv_short FROM members WHERE member_id = $member_id::INTEGER ) AS value;

SELECT 
    'member_cv_long' AS name,
    'textarea' AS type,
    'Long CV' AS label,
    'CV détaillé. Format Markdown (dans la liste générale des membres utilisez [preview] pour vérifier le balisage md)' AS description,
    (SELECT member_cv_long FROM members WHERE member_id = $member_id::INTEGER ) AS value;

SELECT 
    'orga_dept_id' AS name,
    'nom du département ou de la filiale de rattachement' AS label,
    'select' AS type,
    6 AS width,
    TRUE AS searchable,
   'Saisissez quelques lettres du titre que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',o.orga_name||'('||o.orga_id||')--'||d.orga_dept_name||'('||d.orga_dept_id ||')', 'value', d.orga_dept_id)  ORDER BY  o.orga_name ASC, d.orga_dept_name ASC)  AS options
    FROM orga_dept AS d
    LEFT JOIN orga AS o 
    ON d.orga_id = o.orga_id;



