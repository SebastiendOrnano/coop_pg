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
    'Gestion des partenaires'            AS title,
    '/b_orga_partners/orga_partner_display_4.sql' AS link;


SELECT 
    'form' AS component,
    'Actualiser le profil sur un résdeau social' AS title,
    'Actualiser' AS validate,
   'Clear' AS reset,
    '/b_orga_partners/orga_partner_update_0.sql?orga_partner_id='|| $orga_partner_id AS action;

SELECT
    'orga_partner_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    TRUE AS required,
    8 AS width,
    (SELECT orga_partner_name  FROM orga_partners WHERE orga_partner_id = $orga_partner_id::INTEGER ) AS value;

SELECT
    'orga_partner_acronym' AS name,
    'text' AS type,  
    'Sigle' AS label,
    4 AS width,
    (SELECT orga_partner_acronym  FROM orga_partners WHERE orga_partner_id = $orga_partner_id::INTEGER ) AS value;

SELECT 
    'orga_partner_punchline' AS name,
    'text' AS type,
    'Punch line' AS label,
    (SELECT orga_partner_punchline  FROM orga_partners WHERE orga_partner_id = $orga_partner_id::INTEGER ) AS value;

SELECT
    'orga_partner_scope' AS name,
    'text' AS type,  
    'Domaine d''activité' AS label,
    4 AS width,
    (SELECT orga_partner_scope  FROM orga_partners WHERE orga_partner_id = $orga_partner_id::INTEGER ) AS value;

 SELECT 
    'orga_partner_type'            AS name,
    'Type'                    AS label,
    'select'                       AS type,
    2                              AS width,
    (SELECT orga_partner_type  FROM orga_partners WHERE orga_partner_id = $orga_partner_id::INTEGER ) AS value,
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
    (SELECT orga_partner_category  FROM orga_partners WHERE orga_partner_id = $orga_partner_id::INTEGER ) AS value,
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
     (SELECT orga_partner_status  FROM orga_partners WHERE orga_partner_id = $orga_partner_id::INTEGER ) AS value,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

 SELECT 
    'orga_partner_date_since'      AS name,
    'Partenaire depuis'            AS label,
    'date'                       AS type, 
     (SELECT orga_partner_date_since  FROM orga_partners WHERE orga_partner_id = $orga_partner_id::INTEGER ) AS value,
    2                            AS width,
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
    'logo de   ' ||(SELECT orga_partner_name FROM orga_partners WHERE orga_partner_id = $orga_partner_id::INTEGER ) AS value,
    'Nom du logo ' AS label,
    'formats acceptés : jpg,jpeg,png' AS description,
    true AS required;

SELECT
    'orga_partner_link' AS name,
    'text' AS type,  
    'Lien vers le site du partenaire' AS label,
     (SELECT orga_partner_link  FROM orga_partners WHERE orga_partner_id = $orga_partner_id::INTEGER ) AS value,
    'https://www.mydomain.com' AS placeholder;


SELECT 
    'orga_partner_summary' AS name,
    'textarea' AS type,
    'Pitch' AS label,
    'Présentation du partenaire. Format Markdown (dans la liste générale des membres utilisez [preview] pour vérifier le balisage md)' AS description,
    (SELECT orga_partner_summary FROM orga_partners WHERE orga_partner_id = $orga_partner_id::INTEGER ) AS value;

SELECT 
    'orga_dept_id' AS name,
    'nom du département ou de la filiale de rattachement' AS label,
    'select' AS type,
     (SELECT orga_dept_id  FROM orga_partners WHERE orga_partner_id = $orga_partner_id::INTEGER ) AS value,
    6 AS width,
    TRUE AS searchable,
    TRUE AS empty_option,
   'Saisissez quelques lettres du titre que vous cherchez ou choississez dans la liste' AS description,
    json_agg(JSON_BUILD_OBJECT('label',o.orga_name||'('||o.orga_id||')--'||d.orga_dept_name||'('||d.orga_dept_id ||')', 'value', d.orga_dept_id)ORDER BY  o.orga_name ASC, d.orga_dept_name ASC)  AS options
    FROM orga_dept AS d
    LEFT JOIN orga AS o 
    ON d.orga_id = o.orga_id;



