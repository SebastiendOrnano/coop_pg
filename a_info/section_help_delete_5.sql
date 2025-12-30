SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

SELECT
    'form'                                AS component,
    'Suppression de la section'            AS title,
    'Supprimer la section'              AS validate,
    'red'                                    AS validate_color,
    '/a_info/section_delete_0.sql?section_id=' ||$section_id AS action;

SELECT 
    'section_id' AS name,
    TRUE AS readonly,
    'Id' AS label,
  2 AS width,
    section_id AS value
FROM info_sections  
WHERE section_id = $section_id;

SELECT 
    'section_number' AS name,
    TRUE AS readonly,
    'N°' AS label,
    2 AS width,
    section_number AS value
FROM info_sections  
WHERE section_id = $section_id;

SELECT 
    'section_category' AS name,
    TRUE AS readonly,
    'Categorie' AS label,
   4 AS width,
    section_category AS value
FROM info_sections  
WHERE section_id = $section_id;

SELECT 
    'section_title' AS name,
    'titre de la section' AS label,
     TRUE AS readonly,
   4 AS width,
    section_title AS value
FROM info_sections  
WHERE section_id = $section_id;

SELECT 
    'section_content' AS name,
    'contenu de la section' AS label,
     TRUE AS readonly,
    section_content AS value
FROM info_sections  
WHERE section_id = $section_id;

SELECT 
    'button' AS component,
    'sm'     AS size;
SELECT 
    '/a_info/section_display_5.sql'     AS link,
    'orange' AS outline,
    'Annuler'  AS title,
    'arrow-back'  AS icon;





