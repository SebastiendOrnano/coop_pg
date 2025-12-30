SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET orga_dept_id = SELECT orga_dept_id FROM orga_dept_members WHERE member_id=$member_id::INTEGER;

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
    '/b_orga_dept_members/orga_dept_member_main_display_4.sql?orga_dept_id='||$orga_dept_id    AS link;

SELECT 
    'form'            AS component,
    'Actualiser le profil de : '|| (SELECT member_first_name ||'   '|| member_last_name FROM orga_dept_members WHERE member_id= $member_id::INTEGER) AS title ,
    'Mettre à jour le profil' AS validate,
    'green'           AS validate_color,
    '/b_orga_dept_members/orga_dept_member_main_update_0.sql?member_id=' || $member_id AS action,
    'Clear'           AS reset;

SELECT 
    'member_id' AS name,
    'hidden' AS type,
    $member_id AS value,
    'id' AS label;
SELECT 
    'member_gender'        AS name,
    'Genre'               AS label,
    'select'                AS type,
    3                      AS width,
    (SELECT member_gender FROM orga_dept_members  WHERE member_id = $member_id::INTEGER ) AS value,
    'Choisir un genre...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM  choices_items AS i 
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='gender';


 SELECT 
    'member_category'        AS name,
    'Categorie'               AS label,
    'select'                AS type,
    3                     AS width,
    (SELECT member_category FROM orga_dept_members  WHERE member_id = $member_id::INTEGER ) AS value,
    'Choisir une categorie...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
   FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='member_category';

 SELECT 
    'member_status'        AS name,
    'Status'               AS label,
    'select'                AS type,
    (SELECT member_status FROM orga_dept_members  WHERE member_id = $member_id::INTEGER ) AS value,
    3                      AS width,
    'Choisir un statut...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT 
    'member_publish'        AS name,
    'Public/privé'               AS label,
    'select'                AS type,
    (SELECT member_publish FROM orga_dept_members  WHERE member_id = $member_id::INTEGER ) AS value,
    3                     AS width,
    'Profil public ou caché...' AS empty_option,
    '[
    {"label": "Public", "value": true},
    {"label": "Privé", "value": false}
    ]'::json AS options

SELECT
    'member_first_name' AS name,
    'text' AS type,  
    'Prénom' AS label,
    'prénom de l''adhérent' AS placeholder,
    6 AS width,
    (SELECT member_first_name  FROM orga_dept_members WHERE member_id = $member_id::INTEGER ) AS value;

SELECT
    'member_last_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    6 AS width,
    'Nom de famille de l''adhérent' AS placeholder,
    (SELECT member_last_name FROM orga_dept_members WHERE member_id = $member_id::INTEGER ) AS value;

SELECT 
    'member_phone' AS name,
    'Téléphone' AS label,
    'text' AS type, 
    6 AS width,
    'téléphone' AS placeholder, 
   (SELECT regex_value FROM regex WHERE regex_name='phone')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='phone')          AS description,
    (SELECT member_phone FROM orga_dept_members WHERE member_id = $member_id::INTEGER ) AS value;

SELECT 
    'member_email' AS name,
    'Email' AS label,
    'text' AS type, 
    6 AS width,
    'email' AS placeholder, 
   (SELECT regex_value FROM regex WHERE regex_name='email')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='email')          AS description,
     (SELECT member_email FROM orga_dept_members WHERE member_id = $member_id::INTEGER ) AS value;

SELECT 
    'member_date_birthday' AS name,
    'Date de naissance' AS label,
    'date'       AS type,
    4 AS width,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          AS description,
    (SELECT member_date_birthday FROM orga_dept_members WHERE member_id = $member_id::INTEGER ) AS value;

 SELECT 
    'member_date_since' AS name,
    'Membre depuis' AS label,
    'date'       AS type,
    4 AS width,
   (SELECT regex_value FROM regex WHERE regex_name='email')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='email')          AS description,
      (SELECT member_date_since FROM orga_dept_members WHERE member_id = $member_id::INTEGER ) AS value;

 SELECT 
    'member_date_last_subscription' AS name,
    'Dernière date cotisation' AS label,
    'date'       AS type,
    4 AS width,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          AS description,
    (SELECT member_date_last_subscription FROM orga_dept_members WHERE member_id = $member_id::INTEGER ) AS value;

SELECT 
    'orga_dept_id' AS name,
    'nom du département ou de la filiale' AS label,
    'select' AS type,
    8 AS width,
    1      AS value,
    TRUE AS searchable,
   'Saisissez quelques lettres du titre que vous cherchez ou choississez dans la liste' AS description,
    (SELECT orga_dept_id FROM orga_dept_members WHERE member_id = $member_id::INTEGER ) AS value,
     json_agg(JSON_BUILD_OBJECT('label',o.orga_name||'('||o.orga_id||')--'||d.orga_dept_name||'('||d.orga_dept_id ||')', 'value', d.orga_dept_id)    ORDER BY  o.orga_name ASC, d.orga_dept_name ASC)  AS options
    FROM orga_dept AS d
    LEFT JOIN orga AS o 
    ON d.orga_id = o.orga_id;
    
SELECT 
    'member_function' AS name,
    'text' AS type,
    'fonction' AS label,
    'fonction ou rôle dans l''organisation' AS description,
    'directeur ou chargé de mission' AS placeholder,
    4 AS width,
    (SELECT member_function FROM orga_dept_members WHERE member_id = $member_id::INTEGER ) AS value;

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
    'Résumé du parcours et des fonctions ' AS description,
    (SELECT member_cv_short FROM orga_dept_members WHERE member_id = $member_id::INTEGER ) AS value;

SELECT 
    'member_cv_long' AS name,
    'textarea' AS type,
    'Long CV' AS label,
    'CV détaillé' AS description,
    (SELECT member_cv_long FROM orga_dept_members WHERE member_id = $member_id::INTEGER ) AS value;


