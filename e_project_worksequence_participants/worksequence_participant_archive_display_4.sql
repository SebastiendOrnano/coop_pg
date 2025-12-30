SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;


SET worksequence_name= SELECT worksequence_name FROM project_worksequence WHERE worksequence_id=$worksequence_id::INTEGER;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Superviseur'         as title,
    '/a_panels/panel_supervisor_4.sql' as link;
SELECT 
    'Gestion des séquences'            as title,
     '/b_prm2_sub/worksequence_main_display_4.sql?prm2_id='||$prm2_id  as link;
SELECT 
    'Participants actifs'            as title,
    '/e_project_worksequence_participants/worksequence_participant_main_display_4.sql?worksequence_id='||$worksequence_id  as link;


SELECT 
    'title'     as component,
    'Liste des participants archivés'    as contents,
    3           as level;

SELECT 
    'table'               AS component, 
    TRUE                  AS sort, 
    JSON('{"name":"Remove","tooltip":"Retirer le participant de la liste","link":"/e_project_worksequence_participants/worksequence_participant_main_remove_0.sql?worksequence_participant_id={id}","icon":"logout"}') as custom_actions,
    JSON('{"name":"Open","tooltip":"Réactiver le participant","link":"/e_project_worksequence_participants/worksequence_participant_main_active_0.sql?worksequence_participant_id={id}","icon":"login"}') as custom_actions,
    '/e_project_worksequence_participants/worksequence_participant_main_edit_4.sql?worksequence_participant_id={id}' as edit_url,
    'Nom'                AS markdown,
    'Employee'              AS markdown, 
    'Corporate'              AS markdown, 
    'Team'                 AS markdown,           
    TRUE                  AS search;

SELECT
    p.worksequence_participant_id            AS id,
    p.worksequence_participant_id            AS _sqlpage_id,
    p.worksequence_participant_type          AS type,
    p.worksequence_participant_role          AS role,
   '['||i.prm1_first_name||'  '||i.prm1_last_name||'](/d_prm1/prm1_profile_display_4.sql?prm1_id='||i.prm1_id||')'           AS Nom,
   '['|| c.prm2_sub_name ||'](/d_prm2_sub/prm2_sub_main_view_4.sql?prm2_sub_id='||c.prm2_sub_id||')' as Corporate,
    '['||g.prm3_name ||'](/d_prm3/prm3_main_view_4.sql?prm3_id='||g.prm3_id||')'                                             as Team
   FROM project_worksequence_participants as p
LEFT JOIN (SELECT prm1_id, prm1_first_name, prm1_last_name FROM prm1) as i
ON p.prm1_id = i.prm1_id
LEFT JOIN (SELECT employee_id, prm2_sub_id, prm1_id FROM prm2_sub_employees) as e
ON e.employee_id = p.employee_id 
LEFT JOIN (SELECT prm1_id, prm1_first_name, prm1_last_name FROM prm1) as f
ON e.prm1_id = f.prm1_id

LEFT JOIN (SELECT prm2_sub_id, prm2_sub_name FROM prm2_sub) as c
ON p.prm2_sub_id = c.prm2_sub_id 
LEFT JOIN (SELECT prm3_id, prm3_name FROM prm3) as g
ON p.prm3_id = g.prm3_id 
WHERE 
p.worksequence_id =$worksequence_id::INTEGER AND p.worksequence_participant_status!='active';

