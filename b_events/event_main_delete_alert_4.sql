SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'alert'                    AS component,
    'Suppression d''un événement!' AS title,
    'analyze'                  AS icon,
    'teal'                     AS color,
    TRUE                       AS dismissible,
    'Cette suppression entrainera la suppression de tous ses départements ou filiale ! Par prudence, il vaut mieux choisir le statut ''archivé''' AS description;
SELECT 
    '/b_events/event_main_delete_0.sql?event_id='||$event_id       AS link,
    'Suppression' AS title;
SELECT 
    '/b_events/event_main_display_4.sql'    AS link,
    'Retour à la liste' AS title,
    'secondary'    AS color;



