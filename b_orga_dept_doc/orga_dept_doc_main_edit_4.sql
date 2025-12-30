SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET orga_dept_id = SELECT orga_dept_id FROM orga_dept_docs where orga_doc_id=$orga_doc_id::integer;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Superviseur'         as title,
    '/a_panels/panel_supervisor_4.sql' as link;
SELECT 
    'Gestion des docs d''une filiale'            as title,
    '/b_orga_dept_doc/orga_dept_doc_main_display_4.sql?orga_dept_id='||$orga_dept_id     as link;

SELECT 
    'form'                                           as component,
    'Actualiser les métadonnées d''un document'      as title,
    'Actualiser'                                     as validate,
    'Clear'                                          as reset,
    '/b_orga_dept_doc/orga_dept_doc_main_update_0.sql?orga_doc_id=' || $orga_doc_id as action

SELECT 
    'orga_doc_id'    as name,
    'hidden'         as type,
    $orga_doc_id     as value,
    'id'              as label;

SELECT 
    'orga_dept_id' as name,
    'nom du département ou de la filiale' as label,
    'select' as type,
    12 AS width,
    TRUE as required,
    (SELECT orga_dept_id FROM orga_dept_docs WHERE orga_doc_id = $orga_doc_id::INTEGER ) as value,
    'Saisissez quelques lettres du titre que vous cherchez ou choississez dans la liste' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',o.orga_name||'('||o.orga_id||')--'||d.orga_dept_name||'('||d.orga_dept_id ||')', 'value', d.orga_dept_id)    ORDER BY  o.orga_name ASC, d.orga_dept_name ASC)  AS options
    FROM orga_dept AS d
    LEFT JOIN orga AS o 
    ON d.orga_id = o.orga_id;


SELECT
    'orga_doc_title'                     as name,
    'text'                               as type,  
    'Titre'                              as label,
    (SELECT orga_doc_title  FROM orga_dept_docs WHERE orga_doc_id = $orga_doc_id::INTEGER ) as value,
    TRUE                                as required,
    6                                   AS width;

SELECT
    'orga_doc_author'         as name,
    'text'                    as type,  
    'Author'                  as label,
    (SELECT orga_doc_author  FROM orga_dept_docs WHERE orga_doc_id = $orga_doc_id::INTEGER ) as value,
    6                        AS width;

SELECT 
    'file'                  as type, 
    'orga_doc_url'          as name,
    'document à insérer'    as label,
    '*'                     as accept;

SELECT 
    'orga_doc_summary'     as name,
    'textarea'             as type,
    'Résumé'               as label,
    (SELECT orga_doc_summary FROM orga_dept_docs WHERE orga_doc_id = $orga_doc_id::INTEGER ) as value,
    12                     AS width;

SELECT 
    'orga_doc_keywords'   as name,
    'text'                as type,
    'Mots clés'           as label,
    (SELECT orga_doc_keywords FROM orga_dept_docs WHERE orga_doc_id = $orga_doc_id::INTEGER ) as value,
    'Séparez les mots par une virgule' as description,
    12                    AS width;



 SELECT 
    'orga_doc_date_publication' as name,
    'Date de publication'       as label,
    'date'                      as type,
    (SELECT orga_doc_date_publication  FROM orga_dept_docs WHERE orga_doc_id = $orga_doc_id::INTEGER ) as value,
    3                            AS width,
  (SELECT regex_value FROM regex WHERE regex_name='date')         as pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          as description;

 SELECT 
    'orga_doc_date_period'     as name,
    'Période concernée'        as label,
    'text'                      as type,
    (SELECT orga_doc_date_period  FROM orga_dept_docs WHERE orga_doc_id = $orga_doc_id::INTEGER ) as value,
    2                         AS width,
  (SELECT regex_value FROM regex WHERE regex_name='year')         as pattern,
   (SELECT regex_description FROM regex WHERE regex_name='year')          as description;

 SELECT 
    'orga_doc_lang'         as name,
    'Langue'                 as label,
    'select'                 as type,
    2                        AS width,
    (SELECT orga_doc_lang FROM orga_dept_docs WHERE orga_doc_id = $orga_doc_id::INTEGER ) as value,
    'Choisir une langue...' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='lang';


 SELECT 
    'orga_doc_format'        as name,
    'Format'                 as label,
    'select'                 as type,
    2                       AS width,
   (SELECT orga_doc_format FROM orga_dept_docs WHERE orga_doc_id = $orga_doc_id::INTEGER ) as value,
  'Choisir un format...' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_format';
 
SELECT 
    'orga_doc_number_page' as name,
    'number'               as type,
    'Nombre de pages'     as label,
    (SELECT orga_doc_number_page FROM orga_dept_docs WHERE orga_doc_id = $orga_doc_id::INTEGER ) as value,
    3                     AS width;


SELECT 
    'orga_doc_category'      as name,
    'Catégorie'              as label,
    'select'                 as type,
    3                       AS width,
    (SELECT orga_doc_category FROM orga_dept_docs WHERE orga_doc_id = $orga_doc_id::INTEGER ) as value,
    'Choisir une categorie...' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_category';

SELECT 
    'orga_doc_type'           as name,
    'Type de document'        as label,
    'select'                  as type,
    (SELECT orga_doc_type FROM orga_dept_docs WHERE orga_doc_id = $orga_doc_id::INTEGER ) as value,
    3                         AS width,
    'Choisir un type...' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_type';

SELECT 
    'orga_doc_edition'       as name,
    'Statut d''édition'      as label,
    'select'                 as type,
    3                        AS width,
    (SELECT orga_doc_edition FROM orga_dept_docs WHERE orga_doc_id = $orga_doc_id::INTEGER ) as value,
    'Choisir un statut d''édition' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='edition_status';
                                     
SELECT 
    'orga_doc_status'    as name,
    'Statut de publication'   as label,
    'select'                  as type,
    3                         AS width,
    (SELECT orga_doc_status FROM orga_dept_docs WHERE orga_doc_id = $orga_doc_id::INTEGER ) as value,
    'Choisir un statut de publication..' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';


