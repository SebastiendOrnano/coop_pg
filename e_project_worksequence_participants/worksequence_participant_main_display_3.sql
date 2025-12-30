SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET workpackage_id = SELECT workpackage_id FROM project_worksequence WHERE worksequence_id =$worksequence_id::INTEGER ;
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
    'datagrid'              as component,
    'panel_worksequence_doc_display' as id,
    'Gestion des partcipants de la sequence: '||$worksequence_name as title;

SELECT 
    '/e_project_worksequence_participants/worksequence_participant_main_form1_3.sql?worksequence_id='||$worksequence_id            as link,
    'Ajout d''un nouveau participant (prm1) '                  as description,
    'user-plus'                                      as icon,
    'green'                                         as color;
SELECT 
    '/e_project_worksequence_participants/worksequence_participant_main_form2_3.sql?worksequence_id='||$worksequence_id             as link,
    'Ajout d''un nouveau participant (prm2_sub)'                  as description,
    'user-plus'                                      as icon,
    'orange'                                         as color;
SELECT 
    '/e_project_worksequence_participants/worksequence_participant_main_form3_step1_3.sql?worksequence_id='||$worksequence_id             as link,
    'Ajout d''un nouvel participant (prm2_sub_employees)'                  as description,
    'user-plus'                                      as icon,
    'red'                                         as color;
SELECT 
    '/e_project_worksequence_participants/worksequence_participant_main_form4_3.sql?worksequence_id='||$worksequence_id             as link,
    'Ajout d''un groupe'                  as description,
    'user-plus'                                      as icon,
    'blue'                                         as color;
SELECT  
    '/e_project_worksequence_participants/worksequence_participant_csv_email_0.sql?worksequence_id='||$worksequence_id as link,
    'Téléchargement coordonnées des participants'           as description,
    'file-download'                                         as icon,
    'blue'                                                  as color;

SELECT     'Employee'              AS markdown,
    'title'     as component,
    'Liste des participants actifs'    as contents,
    3           as level;

SELECT 
    'table'               AS component, 
    TRUE                  AS sort, 
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
    '['||i.prm1_first_name||'  '||i.prm1_last_name||'](/d_prm1/prm1_profile_display_3.sql?prm1_id='||i.prm1_id||')'         AS Nom,
    '['||f.prm1_first_name||'  '||f.prm1_last_name||'](/d_prm1/prm1_profile_display_3.sql?prm1_id='||f.prm1_id||')'         AS Employee,
    '['||c.prm2_sub_name ||'](/d_prm2_sub/prm2_sub_main_view_3.sql?prm2_sub_id='||c.prm2_sub_id||')'                         as Corporate,
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
p.worksequence_id =$worksequence_id::INTEGER AND p.worksequence_participant_status='active';

