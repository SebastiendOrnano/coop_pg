SET project_id=SELECT project_id FROM project_building WHERE building_id=$building_id::INTEGER;

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET suffix_role = 
(
	    SELECT
        CASE
            WHEN $user_role = 'supervisor' THEN '_4.sql'
            WHEN $user_role = 'editor' THEN '_3.sql'
        END
);
  
SET redirect_link = '/e_project_building/building_main_display'||$suffix_role||'?project_id='||$project_id;

UPDATE project_building 
SET 
building_name=:building_name,
building_status=:building_status,
building_summary=:building_summary,
building_adress=:building_adress,
building_postal_code=COALESCE(NULLIF(:building_postal_code ,''), NULL)::INTEGER,
building_town=:building_town,
building_country=:building_country,
building_contact_phone=:building_contact_phone,
building_contact_mail=:building_contact_mail,
building_latitude=COALESCE(NULLIF(:building_latitude ,''), NULL)::REAL,
building_longitude=COALESCE(NULLIF(:building_longitude, ''), NULL)::REAL,
building_type =:building_type,
building_accessibility=:building_accessibility,
building_capacity_seats=COALESCE(NULLIF(:building_capacity_seats, ''), NULL)::INTEGER,
building_capacity_standup=COALESCE(NULLIF(:building_capacity_standup,''), NULL)::INTEGER,
updated_at = CURRENT_TIMESTAMP
WHERE building_id = $building_id::INTEGER;


SET building_id = (SELECT MAX(building_id::INTEGER) FROM project_building WHERE building_name = :building_name);

UPDATE project_building_rooms
SET
room_name=:building_name,
room_accessibility=:building_accessibility,
room_capacity_seats=COALESCE(NULLIF(:building_capacity_seats, ''), NULL)::INTEGER,
room_capacity_standup=COALESCE(NULLIF(:building_capacity_standup, ''), NULL)::INTEGER,
updated_at = CURRENT_TIMESTAMP
WHERE building_id=$building_id::INTEGER AND room_rank='main';

UPDATE project_building_rooms
SET
room_status=:building_status,
updated_at = CURRENT_TIMESTAMP
WHERE building_id=$building_id::INTEGER

RETURNING 'redirect' AS component,
$redirect_link AS link;


