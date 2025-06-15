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
            WHEN $user_role = 'editor'  THEN '_3.sql'
        END
);

SET redirect_link1 =
(
    SELECT
        CASE
            WHEN  :worksequence_end_hour_scheduled < :worksequence_start_hour_scheduled
            THEN '/e_project_worksequence/worksequence_main_create_alert1_1.sql?workpackage_id='||$workpackage_id||'&suffix_role='||$suffix_role
            ELSE ''
        END
);

SELECT 
	'redirect' AS component, 
	$redirect_link1 AS link
	WHERE $redirect_link1 != '' OR $redirect1 IS NOT NULL;



SET redirect_link = '/e_project_workpackage/workpackage_hub_display'||$suffix_role||'?workpackage_id='||$workpackage_id::INTEGER;


INSERT INTO project_worksequence
(
	workpackage_id,
	worksequence_name,
	worksequence_status,
	worksequence_type,
	worksequence_summary,
	worksequence_todo,
	room_id,
	worksequence_start_date_scheduled,
	worksequence_start_hour_scheduled,
	worksequence_end_hour_scheduled,
	worksequence_duration_scheduled
	)
VALUES 
(
	$workpackage_id::INTEGER,
	:worksequence_name,
	'active',
	:worksequence_type,
	:worksequence_summary,
	:worksequence_todo,
	COALESCE(NULLIF(:room_id, ''), NULL)::INTEGER,
	COALESCE(NULLIF(:worksequence_start_date_scheduled, ''), NULL)::DATE,
	COALESCE(NULLIF(:worksequence_start_hour_scheduled, ''), NULL)::TIME,
	COALESCE(NULLIF(:worksequence_end_hour_scheduled, ''), NULL)::TIME,
	COALESCE(NULLIF(:worksequence_duration_scheduled, ''), NULL)::TIME
)

RETURNING 'redirect' AS component,
$redirect_link  AS link;


