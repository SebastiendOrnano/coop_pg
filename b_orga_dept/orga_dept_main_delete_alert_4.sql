SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET orga_id = (SELECT orga_id FROM orga_dept  WHERE orga_dept_id=$orga_dept_id::INTEGER);

SELECT 
    'alert'                    AS component,
    'Supprimer un département de l''organisation' AS title,
    'analyze'                  AS icon,
    'teal'                     AS color,
    TRUE                       AS dismissible,
    'La suppression est irréversible et entrainera la suppression de tous les employés et documents liés au département !  
Il est préférable de passer le statut du département à "archive"' AS description_md;

SELECT 
    '/b_orga_dept/orga_dept_main_delete_0.sql?orga_dept_id='||$orga_dept_id      AS link,
    'alert-circle'       AS icon,
    'Je confirme la suppression' AS title,
    'red'    AS color;

SELECT 
    '/b_orga_dept/orga_dept_main_edit_4.sql?orga_dept_id='||$orga_dept_id     AS link,
    'Je ne supprime pas le membre mais je change le statut' AS title,
    'alert-circle'       AS icon,
    'green'    AS color;

SELECT 
    '/b_orga_dept/orga_dept_main_display_4.sql?orga_id='||$orga_id     AS link,
    'annulation'                         AS title,
    'alert-circle'                        AS icon,
    'red'                             AS color;
