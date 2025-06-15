SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'alert'                    AS component,
    'Suppression de l''employé de la liste' AS title,
    'analyze'                  AS icon,
    'teal'                     AS color,
    'Cette suppression n''entrainera pas la suppression de l''employé mais seulement celle de sa présence dans la liste des employés !' AS description;

SET orga_dept_id=(SELECT orga_dept_id FROM members WHERE member_id=$member_id::INTEGER);

SELECT 
    '/b_orga_dept/orga_dept_member_main_display_4.sql?orga_dept_id='||$orga_dept_id    AS link,
    'Retour à la liste' AS title,
    'secondary'    AS color;

SELECT 
    '/b_orga_dept/orga_dept_member_delete_0.sql?member_id='||$member_id  AS link,
    'Retirer l''employé de la liste' AS title;



