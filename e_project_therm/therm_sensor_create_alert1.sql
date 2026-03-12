SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link1 =
CASE WHEN $user_role = 'supervisor' 
THEN  '/e_project_therm/therm_sensor_form_4.sql'
ELSE  '/e_project_therm/therm_sensor_form_3.sql'
END;
SET redirect_link2 =
CASE WHEN $user_role = 'supervisor' 
THEN  '/e_project_therm/therm_sensor_display_4.sql'
ELSE  '/e_project_therm/therm_sensor_display_3.sql'
END;



SELECT 'alert' AS component,
    'Attention' AS title,
    'Il y a déjà un capteur avec ce nom. Vérifier si vous ne faites pas une double saisie, sinon choississez un autre nom.

[Reprenez votre saisie]('||$redirect_link1||')' AS description_md,
    'alert-circle' AS icon,
    'red' AS color;


