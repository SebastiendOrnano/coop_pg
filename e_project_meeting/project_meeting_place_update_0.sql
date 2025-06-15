SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN '/e_project_meeting/project_meeting_place_display_4.sql'
ELSE '/e_project_meeting/project_meeting_place_display_3.sql'
END;

UPDATE project_meeting_places 
SET 
project_meeting_place_name=:project_meeting_place_name,
project_meeting_place_status=:project_meeting_place_status,
project_meeting_place_summary=:project_meeting_place_summary,
project_meeting_place_adress=:project_meeting_place_adress,
project_meeting_place_postal_code=COALESCE(NULLIF(:project_meeting_place_postal_code, ''), NULL)::INTEGER, 
project_meeting_place_town=:project_meeting_place_town,
project_meeting_place_country=:project_meeting_place_country,
project_meeting_place_contact_phone=:project_meeting_place_contact_phone,
project_meeting_place_contact_mail=:project_meeting_place_contact_mail,
project_meeting_place_latitude=COALESCE(NULLIF(:project_meeting_place_latitude, ''), NULL)::NUMERIC(9,6), 
project_meeting_place_longitude=COALESCE(NULLIF(:project_meeting_place_longitude, ''), NULL)::NUMERIC(9,6),
project_meeting_place_type = :project_meeting_place_type,
project_meeting_place_accessibility=:project_meeting_place_accessibility,
project_meeting_place_capacity_seats=COALESCE(NULLIF(:project_meeting_place_capacity_seats, ''), NULL)::INTEGER,
project_meeting_place_capacity_standup=COALESCE(NULLIF(:project_meeting_place_capacity_standup, ''), NULL)::INTEGER,
updated_at = CURRENT_TIMESTAMP
WHERE project_meeting_place_id = $project_meeting_place_id::INTEGER

RETURNING 'redirect' AS component,
$redirect_link AS link;


