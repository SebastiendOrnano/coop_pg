SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'alert'                    as component,
    'Suppression d''un lieu!' as title,
    'analyze'                  as icon,
    'teal'                     as color,
    TRUE                       as dismissible,
    'Cette suppression entrainera la suppression de tous ses élements liés ! Par prudence, il vaut mieux choisir le statut ''archivé''' as description;
SELECT 
'/b_orga_places/orga_place_main_delete_0.sql?place_id='||$place_id       as link,
    'Suppression' as title;
SELECT 
'/b_orga_places/orga_place_main_display_4.sql'    as link,
    'Retour à la liste' as title,
    'secondary'    as color;



