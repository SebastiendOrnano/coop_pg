SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN '/b_events/event_main_display_4.sql'
ELSE '/b_events/event_main_display_3.sql'
END;


INSERT INTO events
(
	event_name,
	event_public_private,
	event_type,
	event_status,
	event_visio,
	event_visio_url,
	event_visio_code,
	space_id,
	event_program_url,
	event_picture_url,
	event_summary,
	event_date,
	event_start_hour,
	event_end_hour,
	event_duration,
	event_audience_target,
	event_participants_nb_max,
	event_registration,
	event_entrance_fee
)
VALUES 
(
	:event_name,
	:event_public_private,
	:event_type,
	:event_status,
	:event_visio,
	:event_visio_url,
	:event_visio_code,
	COALESCE(NULLIF(:space_id, ''), NULL)::INTEGER,
	sqlpage.persist_uploaded_file('event_program_url', 'x_pictures_events', 'pdf,jpg,jpeg,png'),
	sqlpage.persist_uploaded_file('event_picture_url', 'x_pictures_events', 'pdf,jpg,jpeg,png'),
	:event_summary,
	COALESCE(NULLIF(:event_date, ''), NULL)::DATE,
	COALESCE(NULLIF(:event_start_hour, ''), NULL)::TIME,
	COALESCE(NULLIF(:event_end_hour, ''), NULL)::TIME,
	COALESCE(NULLIF(:event_duration, ''), NULL)::TIME,
	:event_audience_target,
	COALESCE(NULLIF(:event_participants_nb_max, ''), NULL)::INTEGER,
	:event_registration::BOOLEAN,
	COALESCE(NULLIF(:event_entrance_fee, ''), NULL)::INTEGER	
)

RETURNING 'redirect' AS component,
	$redirect_link AS link;


