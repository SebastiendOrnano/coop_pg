
SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 



INSERT INTO therm_dual_analysis 
(
    therm_set_sensor_id,
    dataset1_id,
    dataset2_id,
    created_at
)
VALUES
(
    $therm_set_sensor_id::INTEGER,
    :dataset1::INTEGER,
    :dataset2::INTEGER,
    CURRENT_TIMESTAMP
);

SET dual_analysis_id = SELECT MAX(dual_analysis_id) FROM therm_dual_analysis WHERE therm_set_sensor_id=$therm_set_sensor_id::INTEGER;

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN  '/e_project_therm/therm_dual_dataset_analysis_step2_4.sql?dual_analysis_id='||$dual_analysis_id
ELSE  '/e_project_therm/therm_dual_dataset_analysis_step2_3.sql?dual_analysis_id='||$dual_analysis_id
END;

SELECT 'redirect' AS component,
$redirect_link  AS link;