SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;


SET project_number = SELECT count(project_id) FROM project WHERE project_status='active';
SET project_worksequence = SELECT count(worksequence_id) FROM project_worksequence WHERE worksequence_status='active';
SET project_worksequence_participants = SELECT count(worksequence_participant_id) FROM project_worksequence_participants ;

SET duration_scheduled = 
(
    SELECT
    SUM(EXTRACT(EPOCH FROM s.worksequence_end_hour_scheduled - s.worksequence_start_hour_scheduled) * s.worksequence_nb_participants) / 3600
    FROM project_worksequence AS s
    LEFT JOIN project_workpackage AS w 
    ON w.workpackage_id = s.workpackage_id
    LEFT JOIN (SELECT project_id, project_status FROM project) AS p
    ON w.project_id = p.project_id
    WHERE p.project_status = 'active'
);

SET duration_actual = 
    (
    SELECT
    SUM( EXTRACT(EPOCH FROM s.worksequence_end_hour_actual - s.worksequence_start_hour_actual)* s.worksequence_nb_participants) / 3600
    FROM project_worksequence AS s
    LEFT JOIN (SELECT workpackage_id, project_id FROM project_workpackage) AS w 
    ON w.workpackage_id = s.workpackage_id
    LEFT JOIN (SELECT project_id, project_status FROM project) AS p
    ON w.project_id = p.project_id
     WHERE p.project_status = 'active'
    );

select 
    'title'   as component,
    'Données principales sur les projets en cours' as contents,
    TRUE      as center;



select 
    'big_number'          as component,
    2                     as columns,
    'colorfull_dashboard' as id;
select 
    'Nb de projets'          as title,
    $project_number          as value,
    'red'            as color,
    '#users'         as title_link,
    FALSE            as title_link_new_tab,
    '#users_details' as value_link,
    TRUE             as value_link_new_tab;
select 
    'Nb de séquences de chantiers'  as title,
    $project_worksequence      as value,
    'green'   as color,
    '#orders' as title_link,
    TRUE      as title_link_new_tab;
select 
    'Nb d''heures prévues' as title,
    $duration_scheduled      as value,
    'h'       as unit,
    'red'    as color;
select 
    'Nb d''heures réalisées' as title,
    $duration_actual      as value,
    'h'       as unit,
    'green'    as color;
select 
    'Nb de participants impliqués' as title,
    $duration_actual      as value,
    ''       as unit,
    'blue'    as color;



/*


SELECT 
    'columns' AS component;
SELECT 
    'Projets'   AS title,
    $project_number                 AS value,
    'green'                            AS value_color,
    4                                 AS size,
    'Projets en cours'                AS description,
    'building'                       AS icon,
    'green'                           AS icon_color,
    '/b_about/orga_about.sql'         AS link,
    'Découvrez nos actions'           AS button_text,
    'green'                           AS button_color;
SELECT 
    'Interventions'                       AS title,
    $project_worksequence                AS value,
    'blue'                                AS value_color,
    4                                      AS size,
    'shovel-pitchforks'                   AS icon,
    'blue'                           AS icon_color,
    'Nombre total des chantiers menés'    AS description,
    '/b_about/orga_team.sql'               AS link,
    'Notre équipe !'                       AS button_text,
    'blue'                                 AS button_color;
SELECT 
    'Heures de travail'            AS title,
    $duration_actual/60              AS value,
    'red'                          AS value_color,
    4                              AS size,
    'clock-hour-4'                 AS icon,
    'red'                           AS icon_color,
    'Total des heures du travail accompli par nos équipes ' AS description,
    '/b_about/orga_doc.sql'                     AS link,
    'Nos rapports d''activité'                  AS button_text,
    'red'                                       AS button_color;
*/