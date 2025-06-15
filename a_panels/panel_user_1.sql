
SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_1.sql') AS properties;

SET user_id = (SELECT user_id FROM sessions WHERE sessions.session_token = sqlpage.cookie('session_token')); 

SET username = (
    SELECT users.username FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 


SELECT 
    'datagrid'              AS component,
    'Paramètre de votre profil :    '||$username       AS title,
    'Changer ses coordonnées, son mot de passe...' AS description_md;

SELECT 
    'PASSWORD'  AS title,
    'Changer de mot de passe' AS description,
    'vector' AS icon,
    'red'                    AS color,
    '/a_users/user_password_edit_1.sql?user_id='||$user_id   AS link;

SELECT 
    'USERNAME' AS title,
    '/a_users/user_username_edit_1.sql?user_id='||$user_id     AS link,
    'Changer de nom d''utilisateur' AS description,
    'list-details'           AS icon,
    'green'                    AS color;

SELECT 
    'EMAIL' AS title,
    '/a_users/user_email_edit_1.sql?user_id='||$user_id      AS link,
    'Changer d''email' AS description,
    'list-details'           AS icon,
    'yellow'                    AS color;

SELECT 
    'PROFILE' AS title,
    '/a_users/user_profile_edit_1.sql?user_id='||$user_id      AS link,
    'Actualiser le profil' AS description,
    'list-details'           AS icon,
    'yellow'                    AS color;
