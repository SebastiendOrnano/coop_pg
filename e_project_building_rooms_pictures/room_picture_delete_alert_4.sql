SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET room_id = (SELECT room_id FROM project_building_rooms_pictures WHERE room_picture_id = $room_picture_id::INTEGER) ;
SET building_id = (SELECT building_id FROM project_building_rooms WHERE room_id = $room_id::INTEGER) ;
SET project_id = (SELECT project_id FROM project_building WHERE building_id = $building_id::INTEGER) ;

SELECT 
    'alert'                    AS component,
    'Suppression d''une image!' AS title,
    'analyze'                  AS icon,
    'teal'                     AS color,
    TRUE                       AS dismissible,
    'Cette suppression est irréversible! Par prudence, il vaut mieux choisir le statut ''archivé''  ' AS description;

SELECT 
    '/e_project_building_rooms_pictures/room_picture_delete_0.sql?room_picture_id='||$room_picture_id      AS link,   
    'Suppression'                                                                                          AS title;

SELECT 
    '/e_project_building_rooms_pictures/project_picture_display_4.sql?project_id='||$project_id  AS link,
    'Retour à la liste'                                                                          AS title,
    'secondary'                                                                                  AS color;



