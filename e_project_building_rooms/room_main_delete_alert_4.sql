SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET building_id = (SELECT building_id FROM project_building_rooms WHERE room_id = $room_id) ;


SELECT 
    'alert'                    as component,
    'Suppression d''une salle!' as title,
    'analyze'                  as icon,
    'teal'                     as color,
    TRUE                       as dismissible,
    'Cette suppression entrainera la suppression de tous ses élements liés ! Par prudence, il vaut mieux choisir le statut ''archivé''' as description;
SELECT 
'/e_project_building_rooms/room_main_delete_0.sql?room_id='||$room_id       as link,
    'Suppression' as title;
SELECT 
'/e_project_building_rooms/room_main_display_4.sql?building_id='||$building_id    as link,
    'Retour à la liste' as title,
    'secondary'    as color;



