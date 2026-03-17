SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

INSERT INTO therm_crossanalysis (
    therm_set_id,
    datasetsensor1,
    datasetsensor2,
    crossanalysis_status,
    created_at
)
VALUES (
    $therm_set_id::INTEGER,
    :sensor1::INTEGER,
    :sensor2::INTEGER,
    'active',
    CURRENT_TIMESTAMP
);


SET crossanalysis_id = (SELECT MAX(crossanalysis_id) FROM therm_crossanalysis WHERE datasetsensor1 = :sensor1::INTEGER);

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN '/e_project_therm/therm_set_sensor_crossanalysis_step2_4.sql?crossanalysis_id='||$crossanalysis_id
ELSE '/e_project_therm/therm_set_sensor_crossanalysis_step2_3.sql?crossanalysis_id='||$crossanalysis_id
END;



SELECT
  'redirect' AS component,
  $redirect_link AS link;


