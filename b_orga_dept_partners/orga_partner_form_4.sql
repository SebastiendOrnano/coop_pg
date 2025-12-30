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
    'Structure mère'         AS title,
    '/b_orga_dept/orga_dept_main_display_4.sql?orga_id='||$orga_id AS link;
SELECT 
    'Gestion des partenaires'            AS title,
    '/b_orga_dept_partners/orga_partner_display_4.sql?orga_dept_id='||$orga_dept_id AS link;

SELECT 
    'form' AS component,
    'Créer un partenaire' AS title,
    'Créer' AS validate,
   'Clear' AS reset,
    '/b_orga_dept_partners/orga_partner_create_0.sql?orga_dept_id='||$orga_dept_id AS action;

SELECT
    'orga_partner_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    TRUE AS required,
    8 AS width,
    'Nom du partenaires' AS placeholder;

SELECT
    'orga_partner_acronym' AS name,
    'text' AS type,  
    'Sigle' AS label,
    4 AS width,
    'Sigle du partenaires' AS placeholder;

SELECT 
    'orga_partner_punchline' AS name,
    'text' AS type,
    'Punch line' AS label,
    '3 mots pour qualifier le membre' AS description;

SELECT
    'orga_partner_scope' AS name,
    'text' AS type,  
    'Domaine d''activité' AS label,
    4 AS width;

 SELECT 
    'orga_partner_type'            AS name,
    'Type     '                    AS label,
    'select'                       AS type,
    2                              AS width,
    TRUE                          AS required,
    'Choisir un type...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='partner_type';

 SELECT 
    'orga_partner_category'        AS name,
    'Catégorie'                        AS label,
    'select'                       AS type,
    2                               AS width,
    'Choisir une categorie...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='partner_category';

 SELECT 
    'orga_partner_status'        AS name,
    'Statut'                      AS label,
    'select'                     AS type,
    2                            AS width,
    'Choisir un statut...'       AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

 SELECT 
    'orga_partner_date_since' AS name,
    'MPartenaire depuis' AS label,
    'date'       AS type, 
    2 AS width,
  (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          AS description;

SELECT 
    'file' AS type, 
    'orga_partner_logo_url' AS name,
    'Photo à insérer' AS label,
    'image/*' AS accept;

SELECT 
    'hidden' AS type, 
    'orga_partner_logo_title' AS name,
    'logo de   ' ||(SELECT orga_partner_name FROM orga_dept_partners WHERE orga_partner_id = $orga_partner_id::INTEGER ) AS value,
    'Nom du logo ' AS label,
    'formats acceptés : jpg,jpeg,png' AS description,
    true AS required;

SELECT
    'orga_partner_link' AS name,
    'text' AS type,  
    'Lien vers le site du partenaire' AS label,
    'https://www.mydomain.com' AS placeholder;


SELECT 
    'orga_partner_summary' AS name,
    'textarea' AS type,
    'Pitch' AS label,
    'Présentation du partenaire. Format Markdown (dans la liste générale des membres utilisez [preview] pour vérifier le balisage md)' AS description;



