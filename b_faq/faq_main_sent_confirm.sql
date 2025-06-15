SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SELECT
    'alert'                    as component,
    'Votre message a été envoyé!' as title,
    'analyze'                  as icon,
    'teal'                     as color,
    TRUE                       as dismissible,
    'Merci pour votre contribution' as description;

SELECT 
    '/'    as link,
    'Retour au site' as title,
    'secondary'    as color;

