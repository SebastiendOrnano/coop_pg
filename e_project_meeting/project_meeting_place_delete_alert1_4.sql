SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'alert'                    AS component,
    'Suppression d''un lieu!' AS title,
    'analyze'                  AS icon,
    'teal'                     AS color,
    TRUE                       AS dismissible,
    'Cette suppression entrainera la suppression de tous ses élements liés ! Par prudence, il vaut mieux choisir le statut ''archivé''' AS description;
SELECT 
'/e_project_meeting/project_meeting_place_delete_0.sql?project_meeting_place_id='||$project_meeting_place_id       AS link,
    'Suppression' AS title;
SELECT 
'/e_project_meeting/project_meeting_place_display_4.sql'    AS link,
    'Retour à la liste' AS title,
    'secondary'    AS color;



