SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

select 
    'login'                                             as component,
    '/a_sessions/session_main_create_0.sql'             as action,
    'Ouvrir une session'                                as title,
    'votre email'                                       as username,
    'Password'                                          as password,
    'at'                                                as username_icon,
    'lock'                                              as password_icon,
    'Vous avez oublié votre mot de passe'               as forgot_password_text,
    '/a_sessions/session_create_alert6.sql'             as forgot_password_link,
    'Remember me'                                       as remember_me_text,
    'Pas encore enregistré? [S inscrire ici](/a_users/user_main_form.sql)' as footer_md,
    'Sign in'                                           as validate;



