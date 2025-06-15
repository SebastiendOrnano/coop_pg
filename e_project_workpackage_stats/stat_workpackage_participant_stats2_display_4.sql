SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
 SELECT 
    'Hub du projet'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id      AS link;
 SELECT 
    'Hub du lot de travaux'            AS title,
    '/e_project_workpackage/workpackage_hub_display_4.sql?workpackage_id='||$workpackage_id    AS link; 


select 
    'card' as component,
    'Répartition des temps de travail par  type de participants' as title,
    1      as columns;

select 
    '/e_project_workpackage_stats/stat_workpackage_participant_stats1_display3_4.sql?workpackage_id='||$workpackage_id||'&_sqlpage_embed' as embed;

select 
    'divider' as component,
    'Temps de travail cumulés pour les personnes physiques individuelles (PRM1) sur le lot de travaux'   as contents,
    'left'    as position,
    'blue'    as color;

select 
    'card' as component,
    'Répartition des temps de travail par lot de travaux et type d''organisation' as title,
    2      as columns;
select 
    '/e_project_workpackage_stats/stat_workpackage_participant_stats2_display1_4.sql?workpackage_id='||$workpackage_id||'&_sqlpage_embed' as embed;
select 
    '/e_project_workpackage_stats/stat_workpackage_participant_stats2_display2_4.sql?workpackage_id='||$workpackage_id||'&_sqlpage_embed' as embed;
select 
    '/e_project_workpackage_stats/stat_workpackage_participant_stats2_display3_4.sql?workpackage_id='||$workpackage_id||'&_sqlpage_embed' as embed;
select 
    '/e_project_workpackage_stats/stat_workpackage_participant_stats2_display4_4.sql?workpackage_id='||$workpackage_id||'&_sqlpage_embed' as embed;