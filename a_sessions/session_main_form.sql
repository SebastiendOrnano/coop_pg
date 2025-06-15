SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SELECT 
    'form' AS component, 
    'Sign In' AS title, 
    'Log in' AS validate, 
    '/a_sessions/session_main_create_0.sql' AS action;

SELECT 
    'user_email' AS name, 
    'email' AS label,
    'at' AS prefix_icon, 
    'votre email' AS placeholder;

    SELECT 
    'password' AS name, 
    'lock' AS prefix_icon, 
    'password' AS type;



