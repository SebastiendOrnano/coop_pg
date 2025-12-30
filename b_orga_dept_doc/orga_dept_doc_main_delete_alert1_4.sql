SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

set orga_doc_id=$orga_doc_id;

SELECT 
    'alert'                    as component,
    'Supprimer un document l''organisation' as title,
    'analyze'                  as icon,
    'teal'                     as color,
    TRUE                       as dismissible,
    'La suppression est irréversible!' as description;
SELECT 
    '/b_orga_dept_doc/orga_dept_doc_main_delete_0.sql?orga_doc_id='||$orga_doc_id      as link,
    'alert-circle'       as icon,
    'Je confirme la suppression' as title,
    'red'    as color;

SELECT 
    '/b_orga_dept_doc/orga_dept_doc_main_display_4.sql'    as link,
    'annulation'                         as title,
    'alert-circle'                        as icon,
    'yellow'                             as color;
