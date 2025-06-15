SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;


SELECT 
    'alert'                    as component,
    'Supprimer un membre de l''prm2nisation' as title,
    'analyze'                  as icon,
    'teal'                     as color,
    TRUE                       as dismissible,
    'La suppression est irréversible. Si le membre est lié à des enregistrements dans plusieurs tables,  
il est préférable d''anonymiser son compte' as description_md;

SELECT 
    '/d_prm1/prm1_select_delete_0.sql'     as link,
    'alert-circle'                              as icon,
    'Je confirme la suppression'                as title,
    'red'                                       as color;

SELECT 
    '/d_prm1/prm1_select_anonym_0.sql'                       as link,
    'Je ne supprime pas le membre mais j''anonymise son compte'   as title,
    'alert-circle'                                                as icon,
    'green'                                                       as color;

SELECT 
    '/d_prm1/prm1_select_display_4.sql'    as link,
    'annulation'                                as title,
    'alert-circle'                              as icon,
    'yellow'                                    as color;