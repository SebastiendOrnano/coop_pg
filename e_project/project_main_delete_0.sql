SET workpackage_id = SELECT workpackage_id FROM project_workpackage WHERE project_id  = $project_id::INTEGER ;
SET worksequence_id = SELECT worksequence_id FROM project_worksequence WHERE workpackage_id  = $workpackage_id::INTEGER ;
SET building_id = SELECT building_id FROM project_building WHERE project_id  = $project_id::INTEGER ;
SET room_id = SELECT room_id FROM project_building_rooms WHERE building_id = $building_id::INTEGER ;

SET project_doc_url= (SELECT project_doc_url  FROM project_docs WHERE  project_id = $project_id::INTEGER );
INSERT INTO files_to_erase (file_url) VALUES ($project_doc_url);

SET room_picture_url= (SELECT room_picture_url FROM project_building_rooms_pictures WHERE  room_id = $room_id::INTEGER );
INSERT INTO files_to_erase (file_url) VALUES ($room_picture_url);

DELETE FROM project_worksequence_participants
WHERE worksequence_id  = $worksequence_id::INTEGER ;

DELETE FROM project_worksequence
WHERE workpackage_id  = $workpackage_id::INTEGER ;

DELETE FROM project_workpackage_participants
WHERE workpackage_id  = $workpackage_id::INTEGER ;

DELETE FROM project_workpackage
WHERE project_id  = $project_id::INTEGER ;

DELETE FROM project_building_rooms_pictures
WHERE room_id  = $room_id::INTEGER ;

DELETE FROM project_building_rooms
WHERE building_id  = $building_id::INTEGER ;

DELETE FROM project_building
WHERE project_id  = $project_id::INTEGER ;

DELETE FROM project_docs
WHERE project_id  = $project_id::INTEGER ;

DELETE FROM project
WHERE project_id  = $project_id::INTEGER 

RETURNING
'redirect' AS component,
'/e_project/project_main_display_4.sql' AS link;