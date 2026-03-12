SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET room_id = SELECT room_id FROM therm_set WHERE therm_set_id = $therm_set_id::integer;
SET building_id = SELECT building_id FROM project_building_rooms WHERE room_id = $room_id::integer;
SET project_id = SELECT project_id FROM project_building WHERE building_id = $building_id::integer;


SELECT 
    'alert'                    as component,
    'Suppression d''une salle!' as title,
    'analyze'                  as icon,
    'teal'                     as color,
    TRUE                       as dismissible,
    'Cette suppression entrainera la suppression de tous ses élements liés ! Par prudence, il vaut mieux choisir le statut ''archivé''' as description;
SELECT 
    '/e_project_therm/therm_set_delete_0.sql?therm_set_id='||$therm_set_id       as link,
    'Suppression' as title;
SELECT 
    '/e_project_therm/therm_set_display_4.sql?project_id='||$project_id    as link,
    'Retour à la liste' as title,
    'secondary'    as color;



