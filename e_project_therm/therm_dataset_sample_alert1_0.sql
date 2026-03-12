SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET rights =
CASE WHEN $user_role = 'supervisor' 
THEN  '_4.sql'
ELSE  '_3.sql'
END;

SELECT 'alert' AS component,
    'Attention' AS title,
   'la date de fin est antérieure à la date de début ! 

[Reprenez votre saisie](/e_project_therm/therm_dataset_sample_form'||$rights||'?therm_dataset_id='||$therm_dataset_id||')' AS description_md,    
    'alert-circle' AS icon,
    'red' AS color;