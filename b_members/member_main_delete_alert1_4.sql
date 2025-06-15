SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;


SELECT 
    'alert'                    AS component,
    'Supprimer un membre de l''organisation' AS title,
    'analyze'                  AS icon,
    'teal'                     AS color,
    TRUE                       AS dismissible,
    'La suppression est irréversible. Si le membre est lié à des enregistrements dans plusieurs tables, il est préférable d''anonymiser son compte' AS description;
SELECT 
    '/b_members/member_main_delete_0.sql?member_id='||$member_id      AS link,
    'alert-circle'       AS icon,
    'Je confirme la suppression' AS title,
    'red'    AS color;
SELECT 
    '/b_members/member_main_anonym_0.sql?member_id='||$member_id      AS link,
    'Je ne supprime pas le membre mais j''anonymise son compte' AS title,
    'alert-circle'       AS icon,
    'green'    AS color;
SELECT 
    '/b_members/member_main_display_4.sql'    AS link,
    'annulation'                         AS title,
    'alert-circle'                        AS icon,
    'yellow'                             AS color;

    SET anonymous = SELECT sqlpage.hash_password('anonymous');
    set member_id=$member_id::INTEGER;