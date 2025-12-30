SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;


SELECT 
    'alert'                    AS component,
    'Supprimer un utilisateur' AS title,
    'analyze'                  AS icon,
    'teal'                     AS color,
    TRUE                       AS dismissible,
    'La suppression est irréversible. Si l''utilisateur est lié à des enregistrements dans plusieurs tables, il est préférable d''anonymiser son compte' AS description;

SELECT 
    '/a_users/user_main_delete_0.sql?user_id='||$user_id      AS link,
    'alert-circle'       AS icon,
    'Je confirme la suppression' AS title,
    'red'    AS color;

SELECT 
    '/a_users/user_main_delete_anonym_0.sql?user_id='||$user_id      AS link,
    'Je ne supprime pas l''utilisateur mais j''anonymise son compte' AS title,
    'alert-circle'                                                   AS icon,
    'green'                                                          AS color;
    
SELECT 
    '/a_users/user_main_display_5.sql'    AS link,
    'annulation. retour à la liste'      AS title,
    'alert-circle'                        as icon,
    'yellow'                             as color;

