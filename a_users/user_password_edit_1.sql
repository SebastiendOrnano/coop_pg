SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_1.sql') AS properties;

SELECT 'form' AS component,
    'Changer de mot de passe' AS title,
    'Changer le mot de passe' AS validate,
    '/a_users/user_password_update_0.sql?user_id='||$user_id AS action;

SELECT 'username' AS name,
   'nom d''utilisateur' AS label,
   TRUE AS readonly,
   4 AS width,
   (SELECT username FROM users WHERE user_id=$user_id::INTEGER ) AS value;

SELECT 'last_name' AS name,
    'nom de famille' AS label,
    TRUE AS readonly,
    4 AS width,
    (SELECT user_last_name FROM users WHERE user_id=$user_id::INTEGER ) AS value;

SELECT 'first_name' AS name,
    'prénom' AS label,
    TRUE AS readonly,
    4 AS width,
    (SELECT user_first_name FROM users WHERE user_id=$user_id::INTEGER ) AS value;

SELECT 
    'user_email' AS name, 
    'votre email actuel' AS label,
    'at' AS prefix_icon, 
     6 AS width,
    TRUE AS readonly,
    (SELECT user_email FROM users WHERE user_id=$user_id::INTEGER ) AS value,
    'votre email' AS placeholder;

SELECT 'password' AS name, 
       'password' AS type,
        'lock' AS prefix_icon, 
          6 AS width,
        'Votre mot de passe actuel (pour controle)' AS label,
 /*   (SELECT regex_value FROM regex WHERE regex_name='password')         AS pattern,*/
    (SELECT regex_description FROM regex WHERE regex_name='password')          AS description;

SELECT 'password_new' AS name, 
       'password' AS type,
        'Votre nouveau mot de passe' AS label,
    (SELECT regex_value FROM regex WHERE regex_name='password')         AS pattern,
    (SELECT regex_description FROM regex WHERE regex_name='password')          AS description;

SELECT 'password_new_check' AS name, 
       'password' AS type,
        'Contrôle du nouveau mot de passe' AS label,
    (SELECT regex_value FROM regex WHERE regex_name='password')         AS pattern,
    (SELECT regex_description FROM regex WHERE regex_name='password')          AS description;

