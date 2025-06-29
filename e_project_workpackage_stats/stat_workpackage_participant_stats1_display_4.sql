SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;


SET project_id = SELECT project_id FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER;
SET workpackage_name= SELECT workpackage_name FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER;

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
    '/e_project_workpackage/workpackage_hub_display_4.sql?workpackage_id='||$workpackage_id     AS link;   

SELECT 'text' as component;
SELECT '*Le calcul du temps de travail est basé sur le temps des séquences de chantier qui constituent un lot de travaux*' as contents_md;

SET duration_scheduled = 
(
    SELECT
    SUM(EXTRACT(EPOCH FROM s.worksequence_end_hour_scheduled - s.worksequence_start_hour_scheduled) * s.worksequence_nb_participants) / 3600
    FROM project_worksequence AS s
    LEFT JOIN (SELECT workpackage_id FROM project_workpackage) AS w 
    ON w.workpackage_id = s.workpackage_id
    WHERE w.workpackage_id = $workpackage_id::INTEGER
);

SET duration_actual = 
    (
    SELECT
    SUM( EXTRACT(EPOCH FROM s.worksequence_end_hour_actual - s.worksequence_start_hour_actual)* s.worksequence_nb_participants) / 3600
    FROM project_worksequence AS s
    LEFT JOIN (SELECT workpackage_id FROM project_workpackage) AS w 
    ON w.workpackage_id = s.workpackage_id
    WHERE w.workpackage_id = $workpackage_id::INTEGER
    );


SELECT 
    'columns' AS component;
SELECT 
    'TOTAL Heures de travail prévues'   AS title,
    $duration_scheduled::REAL             AS value,
    'red'                            AS value_color,
    4                                 AS size,
    $workpackage_name||' :   Nb d''heures prévues'                AS description,
    'shovel-pitchforks'                       AS icon,
    'red'                           AS icon_color,
    'red'                           AS button_color;
SELECT 
    'TOTAL Heures de travail réalisées'   AS title,
   $duration_actual::REAL                  AS value,
    'green'                            AS value_color,
    4                                 AS size,
    $workpackage_name||' :   Nb d''heures réalisées'                AS description,
    'shovel-pitchforks'                       AS icon,
    'green'                           AS icon_color,
    'green'                           AS button_color;


select 
    'card' as component,
    'Répartition des temps de travail par lot de travaux et type d''organisation' as title,
    2      as columns;
select 
    '/e_project_workpackage_stats/stat_workpackage_participant_stats1_display1_4.sql?workpackage_id='||$workpackage_id||'&_sqlpage_embed' as embed;
select 
    '/e_project_workpackage_stats/stat_workpackage_participant_stats1_display3_4.sql?workpackage_id='||$workpackage_id||'&_sqlpage_embed' as embed;

select 
    'card' as component,
    'Temps de travail cumulé par lot de travaux' as title,
    2      as columns;
select 
    '/e_project_workpackage_stats/stat_workpackage_participant_stats1_display6_4.sql?workpackage_id='||$workpackage_id||'&_sqlpage_embed' as embed;
select 
    '/e_project_workpackage_stats/stat_workpackage_participant_stats1_display7_4.sql?workpackage_id='||$workpackage_id||'&_sqlpage_embed' as embed;