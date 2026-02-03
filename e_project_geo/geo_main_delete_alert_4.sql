SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET project_id= SELECT project_id FROM project_geo WHERE geo_id=$geo_id::INTEGER;
 

SELECT 
    'alert'                    AS component,
    'Suppression d''un lieu!' AS title,
    'analyze'                  AS icon,
    'teal'                     AS color,
    TRUE                       AS dismissible,
    'Cette suppression entrainera la suppression de tous ses élements liés ! Par prudence, il vaut mieux choisir le statut ''archivé''' AS description;
SELECT 
'/e_project_geo/geo_main_delete_0.sql?geo_id='||$geo_id       AS link,
    'Suppression' AS title;
SELECT 
'/e_project_geo/geo_main_display_4.sql?project_id='||$project_id   AS link,
    'Retour à la liste' AS title,
    'secondary'    AS color;



