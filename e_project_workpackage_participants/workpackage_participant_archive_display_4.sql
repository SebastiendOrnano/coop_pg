SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;


SET workpackage_name= SELECT workpackage_name FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER;
SET project_id = SELECT project_id FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
 SELECT 
    'Retour à la liste des projets'            AS title,
    '/e_project/project_main_display_4.sql'     AS link;
 SELECT 
    'Retour au hub du projet'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link; 
SELECT 
    'Retour à la gestion des lots de travaux'    AS title,
    '/e_project_workpackage/workpackage_hub_display_4.sql?workpackage_id='||$workpackage_id      AS link;
SELECT 
    'Participants actifs'    AS title,
    '/e_project_workpackage_participants/workpackage_participant_main_display_4.sql?workpackage_id='||$workpackage_id AS link;


SELECT 
    'title'     AS component,
    'Liste des participants archivés'    AS contents,
    3           AS level;

SELECT 
    'table'               AS component, 
    TRUE                  AS sort, 
    JSON('{"name":"Open","tooltip":"Réactiver le participant dans la liste","link":"/e_project_workpackage_participants/workpackage_participant_main_open_0.sql?workpackage_participant_id={id}","icon":"login"}') as custom_actions,
    '/e_project_workpackage_participants/workpackage_participant_main_edit_4.sql?workpackage_participant_id={id}' as edit_url,
     'Nom'                AS markdown,
    'Corporate'              AS markdown,            
    TRUE                  AS search;

SELECT
    p.workpackage_participant_id            AS id,
    p.workpackage_participant_id            AS _sqlpage_id,
    p.workpackage_participant_type          AS type,
    p.workpackage_participant_role          AS role,
   '['||i.prm1_first_name||'  '||i.prm1_last_name||'](/d_prm1/prm1_profile_display_4.sql?prm1_id='||i.prm1_id||')'           AS Nom,
   '['|| c.prm2_sub_name ||'](/d_prm2_sub/prm2_sub_main_view_4.sql?prm2_sub_id='||c.prm2_sub_id||')' AS Corporate,
    '['|| d.prm3_name ||'](/d_prm3/prm3_main_view_4.sql?prm3_id='||d.prm3_id||')' AS Team
FROM project_workpackage_participants AS p
LEFT JOIN (SELECT prm1_id, prm1_first_name, prm1_last_name FROM prm1) AS i
ON p.prm1_id = i.prm1_id 
LEFT JOIN (SELECT prm2_sub_id, prm2_sub_name FROM prm2_sub) AS c
ON p.prm2_sub_id = c.prm2_sub_id 
LEFT JOIN (SELECT prm3_id, prm3_name FROM prm3) AS d
ON p.prm3_id = d.prm3_id 
WHERE 
p.workpackage_id =$workpackage_id::INTEGER AND p.workpackage_participant_status!='active';

