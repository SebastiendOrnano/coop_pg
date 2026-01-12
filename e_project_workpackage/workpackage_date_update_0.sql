SET project_id = (SELECT project_id FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER );

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN  '/e_project_workpackage/workpackage_date_confirm_4.sql?workpackage_id='||$workpackage_id
ELSE  '/e_project_workpackage/workpackage_date_confirm_3.sql?workpackage_id='||$workpackage_id
END;



SET workpackage_date_end_scheduled =
CASE
    WHEN :workpackage_date_start_scheduled IS NULL THEN NULL
    WHEN :workpackage_date_start_scheduled IS NOT NULL AND :workpackage_duration_scheduled IS NULL THEN NULL
    ELSE (:workpackage_date_start_scheduled::DATE + :workpackage_duration_scheduled::INTEGER)::DATE
END;

UPDATE project_workpackage
SET 
workpackage_date_start_scheduled=:workpackage_date_start_scheduled::DATE,
workpackage_date_start_actual=COALESCE(NULLIF(:workpackage_date_start_actual, ''), NULL)::DATE,
workpackage_date_end_actual=$workpackage_date_end_actual::DATE,
workpackage_duration_scheduled=COALESCE(NULLIF(:workpackage_duration_scheduled, ''), NULL)::INTEGER,
workpackage_duration_actual = COALESCE(NULLIF(:workpackage_duration_actual, ''), NULL)::INTEGER,
updated_at = CURRENT_TIMESTAMP
WHERE workpackage_id = $workpackage_id::INTEGER;


WITH RECURSIVE cte_child(workpackage_id,workpackage_parent_id, workpackage_date_start_scheduled, workpackage_duration_scheduled, workpackage_date_end_scheduled) AS 
(
    SELECT
        s.workpackage_id,
        s.workpackage_parent_id,
        s.workpackage_date_start_scheduled,
        s.workpackage_duration_scheduled,
        s.workpackage_date_end_scheduled
    FROM project_workpackage AS s
    WHERE s.workpackage_id =$workpackage_id::INTEGER  
    
    UNION ALL  
    
    SELECT 
        s.workpackage_id::INTEGER,
        s.workpackage_parent_id::INTEGER,
        c.workpackage_date_start_scheduled::DATE + c.workpackage_duration_scheduled::INTEGER,
        s.workpackage_duration_scheduled,
        s.workpackage_date_end_scheduled
     FROM project_workpackage AS s
     join cte_child  AS c on c.workpackage_id = s.workpackage_parent_id
)

--SELECT * FROM cte_child;

UPDATE project_workpackage AS s
SET workpackage_date_start_scheduled = c.workpackage_date_start_scheduled FROM cte_child AS c WHERE s.workpackage_id IN (SELECT c.workpackage_id  FROM cte_child);

UPDATE project_workpackage
SET 
workpackage_date_end_scheduled = (workpackage_date_start_scheduled::DATE + workpackage_duration_scheduled::INTEGER)::DATE,
updated_at = CURRENT_TIMESTAMP

SELECT 'redirect' AS component,
$redirect_link AS link;

