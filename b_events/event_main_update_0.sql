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

SET event_program_url = sqlpage.persist_uploaded_file('event_program_url', 'x_pictures_events', 'pdf,jpg,jpeg,png');
SET event_picture_url = sqlpage.persist_uploaded_file('event_picture_url', 'x_pictures_events', 'pdf,jpg,jpeg,png');

UPDATE events
SET
	event_name=:event_name,
	event_public_private=:event_public_private,
	event_status=:event_status,
	event_type=:event_type,
	event_visio=:event_visio,
	event_visio_url=:event_visio_url,
	event_visio_code=:event_visio_code,
	space_id=:space_id::INTEGER,
    event_program_url= 
    CASE  
    WHEN $event_program_url IS NULL OR $event_program_url ='' THEN event_program_url
    ELSE $event_program_url
    END,
	event_picture_url=
    CASE  
    WHEN $event_picture_url IS NULL OR $event_picture_url ='' THEN event_picture_url
    ELSE $event_picture_url
    END,
	event_summary=:event_summary,
	event_date=COALESCE(NULLIF(:event_date, ''), NULL)::DATE,
	event_start_hour=COALESCE(NULLIF(:event_start_hour, ''), NULL)::TIME,
	event_end_hour=COALESCE(NULLIF(:event_end_hour, ''), NULL)::TIME,
	event_duration=COALESCE(NULLIF(:event_duration, ''), NULL)::TIME,
	event_audience_target=:event_audience_target,
	event_participants_nb_max=COALESCE(NULLIF(:event_participants_nb_max, ''), NULL)::INTEGER,
	event_registration=:event_registration::BOOLEAN,
	event_entrance_fee=COALESCE(NULLIF(:event_entrance_fee, ''), NULL)::INTEGER	
WHERE event_id=$event_id::INTEGER

RETURNING 'redirect' AS component,
	$redirect_link AS link;



