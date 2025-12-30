SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET place_id = (SELECT place_id FROM place_spaces WHERE space_id = $space_id::INTEGER) ;


SELECT 
    'alert'                    as component,
    'Suppression d''une salle!' as title,
    'analyze'                  as icon,
    'teal'                     as color,
    TRUE                       as dismissible,
    'Cette suppression entrainera la suppression de tous ses élements liés ! Par prudence, il vaut mieux choisir le statut ''archivé''' as description;
SELECT 
'/b_orga_place_spaces/orga_place_space_main_delete_0.sql?space_id='||$space_id       as link,
    'Suppression' as title;
SELECT 
'/b_orga_place_spaces/orga_place_space_main_display_4.sql?place_id='||$place_id    as link,
    'Retour à la liste' as title,
    'secondary'    as color;



