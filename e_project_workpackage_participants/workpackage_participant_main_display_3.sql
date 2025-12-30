SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET project_id = SELECT project_id FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER;


SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor_3.sql' AS link;
SELECT 
    'Projets'            AS title,
    '/e_project/project_main_display_3.sql'   AS link;   
 SELECT 
    'Hub projet'            AS title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     AS link;   
SELECT 
    'Hub lot de travaux'            AS title,
    '/e_project_workpackage/workpackage_hub_display_3.sql?workpackage_id='||$workpackage_id    AS link;

SELECT 
    'datagrid'              AS component,
    'panel_project_doc_display' AS id,
    'Gestion des partcipants du projet : '||$workpackage_name AS title;
SELECT 
    '/e_project_workpackage_participants/workpackage_participant_main_form1_3.sql?workpackage_id='||$workpackage_id             AS link,
    'Ajout d''un nouveau participant (prm1) '                  AS description,
    'user-plus'                                      AS icon,
    'green'                                         AS color;
SELECT 
    '/e_project_workpackage_participants/workpackage_participant_main_form2_3.sql?workpackage_id='||$workpackage_id             AS link,
    'Ajout d''un nouveau participant (prm2_sub)'                  AS description,
    'user-plus'                                      AS icon,
    'orange'                                         AS color;
SELECT 
    '/e_project_workpackage_participants/workpackage_participant_main_form3_step1_3.sql?workpackage_id='||$workpackage_id             AS link,
    'Ajout d''un nouvel participant (prm2_sub_employees)'                  AS description,
    'user-plus'                                      AS icon,
    'red'                                         AS color;
SELECT 
    '/e_project_workpackage_participants/workpackage_participant_main_form4_3.sql?workpackage_id='||$workpackage_id             AS link,
    'Ajout d''un groupe'                  AS description,
    'user-plus'                                      AS icon,
    'blue'                                         AS color;
SELECT  
    '/e_project_workpackage_participants/workpackage_participant_csv_email_0.sql?workpackage_id='||$workpackage_id AS link,
    'Téléchargement coordonnées des participants'           AS description,
    'file-download'                                         AS icon,
    'blue'                                                  AS color;

SELECT 
    'title'     AS component,
    'Liste des participants actifs'    AS contents,
    3           AS level;

SELECT 
    'table'               AS component, 
    TRUE                  AS sort, 
     '/e_project_workpackage_participants/workpackage_participant_main_edit_3.sql?workpackage_participant_id={id}' as edit_url,
    'Nom'                AS markdown,
    'Corporate'              AS markdown,  
    'Team'              AS markdown,           
    TRUE                  AS search;

SELECT
    p.workpackage_participant_id            AS id,
    p.workpackage_participant_id            AS _sqlpage_idid,
    p.workpackage_participant_type          AS type,
    p.workpackage_participant_role          AS role,
   '['||i.prm1_first_name||'  '||i.prm1_last_name||'](/d_prm1/prm1_profile_display_3.sql?prm1_id='||i.prm1_id||')'           AS Nom,
   '['|| c.prm2_sub_name ||'](/d_prm2_sub/prm2_sub_main_view_3.sql?prm2_sub_id='||c.prm2_sub_id||')' AS Corporate,
    '['|| d.prm3_name ||'](/d_prm3/prm3_main_view_3.sql?prm3_id='||d.prm3_id||')' AS Team
FROM project_workpackage_participants AS p
LEFT JOIN (SELECT prm1_id, prm1_first_name, prm1_last_name FROM prm1) AS i
ON p.prm1_id = i.prm1_id 
LEFT JOIN (SELECT prm2_sub_id, prm2_sub_name FROM prm2_sub) AS c
ON p.prm2_sub_id = c.prm2_sub_id 
LEFT JOIN (SELECT prm3_id, prm3_name FROM prm3) AS d
ON p.prm3_id = d.prm3_id 
WHERE 
p.workpackage_id =$workpackage_id::INTEGER AND p.workpackage_participant_status='active';

