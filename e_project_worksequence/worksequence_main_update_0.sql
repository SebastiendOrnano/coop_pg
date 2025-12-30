SET workpackage_id = (SELECT workpackage_id FROM project_worksequence WHERE worksequence_id=$worksequence_id::INTEGER);

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
            WHEN  :worksequence_end_hour_actual < :worksequence_start_hour_actual
           THEN '/e_project_worksequence/worksequence_main_create_alert2_1.sql?worksequence_id='||$worksequence_id||'&suffix_role='||$suffix_role
            ELSE ''
        END
);

SELECT 
	'redirect' AS component, 
	$redirect_link1 AS link
	WHERE $redirect_link1 != '' OR $redirect1 IS NOT NULL;

SELECT 
	'redirect' AS component, 
	$redirect_link1 AS link
	WHERE $redirect_link1 != '' OR $redirect1 IS NOT NULL;

SET redirect_link = '/e_project_workpackage/workpackage_hub_display'||$suffix_role||'?workpackage_id='||$workpackage_id::INTEGER;

UPDATE project_worksequence 
SET 
worksequence_name=:worksequence_name,
room_id=COALESCE(NULLIF(:room_id, ''), NULL)::INTEGER,
worksequence_status=:worksequence_status,
worksequence_type=:worksequence_type,
worksequence_summary=:worksequence_summary,
worksequence_todo=:worksequence_todo,
worksequence_start_date_scheduled=	COALESCE(NULLIF(:worksequence_start_date_scheduled, ''), NULL)::DATE,
worksequence_start_date_actual=	COALESCE(NULLIF(:worksequence_start_date_actual, ''), NULL)::DATE,
worksequence_start_hour_scheduled=COALESCE(NULLIF(:worksequence_start_hour_scheduled, ''), NULL)::TIME,
worksequence_start_hour_actual=COALESCE(NULLIF(:worksequence_start_hour_actual, ''), NULL)::TIME,
worksequence_end_hour_scheduled=COALESCE(NULLIF(:worksequence_end_hour_scheduled, ''), NULL)::TIME,
worksequence_end_hour_actual=COALESCE(NULLIF(:worksequence_end_hour_actual, ''), NULL)::TIME,
worksequence_duration_scheduled=COALESCE(NULLIF(:worksequence_duration_scheduled, ''), NULL)::TIME,
worksequence_duration_actual=COALESCE(NULLIF(:worksequence_duration_actual, ''), NULL)::TIME,
worksequence_completion_percentage=COALESCE(NULLIF(:worksequence_completion_percentage, ''), NULL)::INTEGER,
updated_at = CURRENT_TIMESTAMP
WHERE worksequence_id = $worksequence_id::INTEGER

RETURNING 'redirect' AS component,
$redirect_link AS link;


