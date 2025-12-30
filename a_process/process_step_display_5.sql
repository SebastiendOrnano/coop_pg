SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Admin'                      AS title,
    'arrow_left_double'                  AS icon,
    '/a_panels/panel_admin_5.sql'        AS link;
SELECT 
    'List des processus'                      AS title,
    'arrow_left'                  AS icon,
    '/a_process/process_main_display_5.sql'        AS link;


SELECT 
    'datagrid'               AS component,
    'process_step_display'   AS id;
SELECT 
     '/a_process/process_step_form_5.sql?process_id='||$process_id    AS link,
    'Ajouter une étape au processus'                                  AS description,
    'list-numbers'                                                   AS icon,
    'green'                                                            AS color;
SELECT 
     '/a_process/process_view_5.sql?process_id='||$process_id    AS link,
    'Visualiser le processus'                                    AS description,
    'timeline-event'                                              AS icon,
    'blue'                                                       AS color;

-- Display steps for the selected process

SELECT
    'form' AS component,
    '' AS validate;

SELECT 
    'Process de rattachement'   AS label,
    'text'                     AS type,
    (SELECT process_title   FROM process WHERE process_id=$process_id::INTEGER ) AS value; 
 
SELECT 
    'title'     AS component,
    'Étapes'    AS contents,
    3           AS level;

SELECT 
    'table'               AS component, 
    'Étapes du processus' AS title, 
    TRUE                  AS sort, 
    '/a_process/process_step_edit_5.sql?process_step_id={id}' as edit_url,
    '/a_process/process_step_delete_0.sql?process_step_id={id}' as delete_url,
    'Description'         AS markdown,
    FALSE                 AS search;

SELECT
    p.process_title                  AS Process,
    s.process_step_id                  as _sqlpage_id,
    s.process_step_number            AS Nb,
    s.process_step_title             AS Step,
    s.process_step_description       AS Description
FROM process_steps AS s
LEFT JOIN (select process_id, process_title from process) AS p
ON p.process_id=s.process_id
WHERE p.process_id = $process_id::INTEGER 
ORDER BY created_at ASC;





