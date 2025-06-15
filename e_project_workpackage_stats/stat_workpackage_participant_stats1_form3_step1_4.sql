SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

set project_id = SELECT project_id FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Superviseur'         as title,
    '/a_panels/panel_supervisor_4.sql' as link;
 SELECT 
    'Hub du projet'            as title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id      as link;
 SELECT 
    'Hub du lot de travaux'            as title,
    '/e_project_workpackage/workpackage_hub_display_4.sql?workpackage_id='||$workpackage_id    as link; 

SELECT 
    'form'      AS component,
    'Choisir une entreprise' as validate,
    '/e_project_workpackage_stats/stat_workpackage_participant_stats1_form3_step2_4.sql?workpackage_id='||$workpackage_id AS action;

SELECT 
   'prm2_sub_id' as name,
    'Nom du participant' as label,
    'select' as type,
    8 AS width,
    TRUE as searchable,
    'Saisissez quelques lettres du nom que vous cherchez ou choississez dans la liste' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.prm2_sub_name, 'value', i.prm2_sub_id)ORDER BY i.prm2_sub_name ASC) AS options
    FROM prm2_sub as i
    LEFT JOIN (SELECT worksequence_id, prm2_sub_id FROM project_worksequence_participants) as p
    on p.prm2_sub_id=i.prm2_sub_id
    LEFT JOIN (SELECT worksequence_id, worksequence_name, workpackage_id, worksequence_start_date_scheduled, worksequence_start_date_actual, worksequence_start_hour_scheduled, worksequence_start_hour_actual, worksequence_end_hour_scheduled, worksequence_end_hour_actual, worksequence_duration_scheduled, worksequence_status  FROM project_worksequence) as s
    ON p.worksequence_id = s.worksequence_id
    LEFT JOIN (SELECT workpackage_id, workpackage_name, project_id FROM project_workpackage) as w
    ON s.workpackage_id = w.workpackage_id
    WHERE w.workpackage_id =$workpackage_id::INTEGER AND s.worksequence_status='active';
