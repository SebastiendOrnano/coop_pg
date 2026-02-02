-- Redirect to the login page if the status is not correct

-- 1) Utilisateur inexistant -> alerte 1
SELECT 
  'redirect' AS component,
  '/a_sessions/session_create_alert1.sql' AS link
WHERE NOT EXISTS (
  SELECT 1 FROM users WHERE user_email = :username
);

-- 2) Utilisateur archivé -> alerte 2
SELECT 
  'redirect' AS component,
  '/a_sessions/session_create_alert2.sql' AS link
WHERE EXISTS (
  SELECT 1 FROM users 
  WHERE user_email = :username
    AND user_status = 'archived'
);



-- Redirect to the login page if the password is not correct


SELECT
    'authentication' AS component,
    '/a_sessions/session_create_alert_0.sql?user_email='||:username  AS link,
    :password AS password,
    (SELECT password_hash  FROM users WHERE user_email = :username AND user_status != 'archived') AS password_hash;

-- The code after this point is only executed if the user has sent the correct password
-- Generate a random session token and set via the "cookie" component in the RETURNING
-- clause.

-- if we haven't been redirected, THEN the password is correct

-- create a new session


WITH user_info AS (
    SELECT username, user_id 
    FROM users 
    WHERE user_email = :username
)
INSERT INTO sessions (session_token, username, user_id) 
VALUES (sqlpage.random_string(32), (SELECT username FROM user_info), (SELECT user_id FROM user_info))
RETURNING
    'cookie' AS component,
    'session_token' AS name,
    false as secure,
    session_token AS value;


-- The user browser will now have a cookie named `session_token` that we can check later
-- to see if the user is logged in.

SELECT
    'redirect' AS component,
    '/a_sessions/session_redirect_0.sql' AS link;
