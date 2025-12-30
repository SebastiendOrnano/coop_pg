SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'alert'                    AS component,
    'Suppression d''un lieu!' AS title,
    'analyze'                  AS icon,
    'teal'                     AS color,
    TRUE                       AS dismissible,
    'Il n''est pas possible de supprimer ce lieu car il est utilisé pour une réunion' AS description;

SELECT 
'/e_project_meeting/project_meeting_place_display_4.sql'    AS link,
    'Retour à la liste' AS title,
    'secondary'    AS color;



