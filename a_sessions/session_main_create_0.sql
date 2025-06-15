-- Redirect to the login page if the status is not correct

SET user_status = SELECT user_status FROM users WHERE user_email = :user_email;
SET user_id = SELECT user_id FROM users WHERE user_email = :user_email;

SET redirect_link = (
    SELECT
        CASE
            WHEN $user_id IS NULL
            THEN '/a_sessions/session_create_alert1.sql'
            WHEN $user_status = 'archived'
            THEN '/a_sessions/session_create_alert2.sql'
            ELSE ''
        END
);

SELECT 
'redirect' AS component, 
$redirect_link AS link
WHERE $redirect IS NOT NULL;

-- Redirect to the login page if the password is not correct


SELECT
    'authentication' AS component,
    '/a_sessions/session_create_alert_0.sql?user_email='||:user_email  AS link,
    :password AS password,
    (SELECT password_hash  FROM users WHERE user_email = :user_email AND user_status != 'archived') AS password_hash;

-- The code after this point is only executed if the user has sent the correct password
-- Generate a random session token and set via the "cookie" component in the RETURNING
-- clause.

-- if we haven't been redirected, THEN the password is correct

-- create a new session


WITH user_info AS (
    SELECT username, user_id 
    FROM users 
    WHERE user_email = :user_email
)
INSERT INTO sessions (session_token, username, user_id) 
VALUES (sqlpage.random_string(32), (SELECT username FROM user_info), (SELECT user_id FROM user_info))
RETURNING
     'cookie' AS component,
    'session_token' AS name,
    session_token AS value;


-- The user browser will now have a cookie named `session_token` that we can check later
-- to see if the user is logged in.

SELECT
    'redirect' AS component,
    '/a_sessions/session_redirect_0.sql' AS link;