SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN  '/e_project_therm/therm_dual_analysis_sample_form_4.sql?dual_analysis_id='||$dual_analysis_id
ELSE  '/e_project_therm/therm_dual_analysis_sample_form_3.sql?dual_analysis_id='||$dual_analysis_id
END;




SELECT 'alert' AS component,
    'Attention' AS title,
    'la date de fin est antérieure à la date de début! ou le début de l''échantillon est inferieur au début du dataset source ou sa fin est supérieur à la fin du dataset source

[Reprenez votre saisie]('||$redirect_link||')' AS description_md,
    'alert-circle' AS icon,
    'red' AS color;