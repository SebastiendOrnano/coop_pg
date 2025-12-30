SELECT
    'redirect' AS component,
    CASE
        WHEN NOT EXISTS (SELECT 1 FROM users u2 WHERE u2.user_email = $user_email) THEN '/a_sessions/session_create_alert1.sql'  -- User does not exist
        WHEN (SELECT u.user_status FROM users u WHERE u.user_email = $user_email) = 'archived' THEN '/a_sessions/session_create_alert2.sql'  -- User is archived
        ELSE '/a_sessions/session_create_alert3.sql'  -- User exists and is active but password is wrong
    END AS link
FROM
    users as u;
