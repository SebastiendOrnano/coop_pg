SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;


SET prm3_name= SELECT prm3_name FROM prm3 WHERE prm3_id=$prm3_id::INTEGER;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Superviseur'         as title,
    '/a_panels/panel_supervisor_4.sql' as link;
SELECT 
    'Retour gestion des groupements'    as title,
    '/d_prm3/prm3_main_display_4.sql'  as link;

SELECT 
    'datagrid'              as component,
    'panel_prm3_doc_display' as id,
    'Gestion des partcipants du groupe : '||$prm3_name as title;
SELECT 
    '/d_prm3_participants/prm3_participant_main_form1_4.sql?prm3_id='||$prm3_id             as link,
    'Création d''un nouveau participant (prm1) '                  as description,
    'user-plus'                                      as icon,
    'green'                                         as color;
SELECT 
    '/d_prm3_participants/prm3_participant_main_form2_4.sql?prm3_id='||$prm3_id             as link,
    'Création d''un nouveau participant (prm2_sub)'                  as description,
    'user-plus'                                      as icon,
    'orange'                                         as color;
SELECT 
    '/d_prm3_participants/prm3_participant_main_form3_step1_4.sql?prm3_id='||$prm3_id             as link,
    'Création d''un nouvel participant (prm2_sub_employees)'                  as description,
    'user-plus'                                      as icon,
    'red'                                         as color;
SELECT 
    '/d_prm3_participants/prm3_participant_archive_display_4.sql?prm3_id='||$prm3_id as link,
    'Visualiser les employés achivés'                       as description,
    'archive'                                         as icon,
    'green'                                                 as color;

SELECT  
    '/d_prm3_participants/prm3_participant_csv_email_0.sql?prm3_id='||$prm3_id as link,
    'Téléchargement coordonnées des participants'           as description,
    'file-download'                                         as icon,
    'blue'                                                  as color;

SELECT 
    'title'     as component,
    'Liste des participants actifs'    as contents,
    3           as level;

SELECT 
    'table'               AS component, 
    TRUE                  AS sort, 
    JSON('{"name":"Archive","tooltip":"archiver le participant","link":"/d_prm3_participants/prm3_participant_main_archive_0.sql?prm3_participant_id={id}","icon":"archive"}') as custom_actions,
    JSON('{"name":"Remove","tooltip":"Retirer de la liste","link":"/d_prm3_participants/prm3_participant_main_remove_0.sql?prm3_participant_id={id}","icon":"door-exit"}') as custom_actions,
    '/d_prm3_participants/prm3_participant_main_edit_4.sql?prm3_participant_id={id}' as edit_url,
    'Nom'                AS markdown,
    'Employee'              AS markdown,
    'Corporate'              AS markdown,            
    TRUE                  AS search;

SELECT
    p.prm3_participant_id            AS id,
    p.prm3_participant_id            AS _sqlpage_id,
    p.prm3_participant_type          AS type,
    p.prm3_participant_role          AS role,
   '['||i.prm1_first_name||'  '||i.prm1_last_name||'](/d_prm1/prm1_profile_display_4.sql?prm1_id='||i.prm1_id||')'           AS Nom,
   '['||f.prm1_first_name||'  '||f.prm1_last_name||'](/d_prm1/prm1_profile_display_4.sql?prm1_id='||f.prm1_id||')'         AS Employee, 
   '['|| c.prm2_sub_name ||'](/d_prm2_sub/prm2_sub_main_view_4.sql?prm2_sub_id='||c.prm2_sub_id||')' as Corporate
FROM prm3_participants as p
LEFT JOIN (SELECT prm1_id, prm1_first_name, prm1_last_name FROM prm1) as i
ON p.prm1_id = i.prm1_id
LEFT JOIN (SELECT employee_id, prm2_sub_id, prm1_id FROM prm2_sub_employees) as e
ON e.employee_id = p.employee_id 
LEFT JOIN (SELECT prm1_id, prm1_first_name, prm1_last_name FROM prm1) as f
ON e.prm1_id = f.prm1_id
LEFT JOIN (SELECT prm2_sub_id, prm2_sub_name FROM prm2_sub) as c
ON p.prm2_sub_id = c.prm2_sub_id 
WHERE 
p.prm3_id = $prm3_id::INTEGER AND p.prm3_participant_status='active';

