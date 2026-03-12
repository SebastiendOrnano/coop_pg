SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN  '/e_project_therm/therm_set_display_4.sql?project_id='||$project_id
ELSE  '/e_project_therm/therm_set_display_3.sql?project_id='||$project_id
END;

INSERT INTO therm_set
(
    therm_set_name,
    room_id,
    therm_set_description,
    therm_set_status
)
VALUES
(
    :therm_set_name,
    :room_id::INTEGER,
    :therm_set_description,
    'active'
)
RETURNING 'redirect' AS component,
          :redirect_link AS link;
