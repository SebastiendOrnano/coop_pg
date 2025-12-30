SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET orga_dept_id= SELECT orga_dept_id FROM orga_dept_docs WHERE orga_doc_id=$orga_doc_id::INTEGER;

SELECT 
    'alert'                    AS component,
    'Suppression d''un document de la liste' AS title,
    'analyze'                  AS icon,
    'teal'                     AS color,
    'Cette suppression n''entrainera pas la suppression du document mais seulement celle de sa présence dans la liste des documents !' AS description;



SELECT 
    '/b_orga_dept_doc/orga_dept_doc_main_display_4.sql?orga_dept_id='||$orga_dept_id    AS link,
    'Retour à la liste des docs' AS title,
    'secondary'    AS color;

    SELECT 
    '/b_orga_dept_doc/orga_dept_doc_remove_0.sql?orga_doc_id='||$orga_doc_id  AS link,
    'Retirer le document de la liste' AS title;



