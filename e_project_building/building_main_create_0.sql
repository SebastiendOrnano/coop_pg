SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN  '/e_project_building/building_main_display_4.sql?project_id='||$project_id
ELSE  '/e_project_building/building_main_display_3.sql?project_id='||$project_id
END;

INSERT INTO project_building
(
	project_id,
	building_name,
	building_status,
	building_summary,
	building_adress,
	building_postal_code,
	building_town,
	building_country,
	building_contact_phone,
	building_contact_mail,
	building_latitude,
	building_longitude,
	building_type,
	building_accessibility,
	building_capacity_seats,
	building_capacity_standup
	)
VALUES 
(
	$project_id::INTEGER,
	:building_name,
	:building_status,
	:building_summary,
	:building_adress,
	COALESCE(NULLIF(:building_postal_code,''), NULL)::INTEGER,
	:building_town,
	:building_country,
	:building_contact_phone,
	:building_contact_mail,
	COALESCE(NULLIF(:building_latitude ,''), NULL)::REAL,
	COALESCE(NULLIF(:building_longitude, ''), NULL)::REAL,
	:building_type,
	:building_accessibility,
	COALESCE(NULLIF(:building_capacity_seats, ''), NULL)::INTEGER,
	COALESCE(NULLIF(:building_capacity_standup, ''), NULL)::INTEGER
)

-- Get the last inserted topic ID

SET building_id = (SELECT MAX(building_id::INTEGER) FROM project_building WHERE building_name = :building_name);

INSERT INTO project_building_rooms
(
room_name,
building_id,
room_status, 
room_rank,
room_type,
room_accessibility,
room_capacity_seats,
room_capacity_standup
)
SELECT
:building_name,
$building_id::INTEGER,
'active',
'main',
'main_building',
:building_accessibility,
COALESCE(NULLIF(:building_capacity_seats, ''), NULL)::INTEGER,
COALESCE(NULLIF(:building_capacity_standup, ''), NULL)::INTEGER

WHERE :building_name IS NOT NULL

RETURNING 'redirect' AS component,
$redirect_link  AS link;


