SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET project_name = SELECT project_name FROM project WHERE project_id=$project_id::INTEGER ;


SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
 SELECT 
    'Projets'            AS title,
    '/e_project/project_main_display_4.sql'     AS link;   


SELECT 
    'datagrid'              AS component,
    'panel_hub_workspace_display' AS id,
    'TABLEAU DE BORD DU PROJET : '||$project_name AS title;

SELECT
    '/e_project_stats/stat_project_timeline_display_4.sql?project_id='||$project_id  AS link,
    'Planning des lots de travaux'                      AS description,
    'treadmill'                                     AS icon,
    'yellow'                                              AS color;

SELECT
    '/e_project_stats/stat_project_cost_display_4.sql?project_id='||$project_id  AS link,
    'Coûts des travaux par lot de travaux'                      AS description,
    'currency-euro'                                     AS icon,
    'blue'                                           AS color;

SELECT
    '/e_project_stats/stat_project_carbon_footprint_display_4.sql?project_id='||$project_id  AS link,
    'Bilan carbone par lot de travaux'                      AS description,
    'alarm-smoke'                                     AS icon,
    'green'                                           AS color;
SELECT
    '/e_project_stats/stat_project_waste_display_4.sql?project_id='||$project_id  AS link,
    'Bilan déchets'                      AS description,
    'archive'                                     AS icon,
    'blue'                                           AS color;


SELECT
    '/e_project_stats/stat_project_participant_stats1_display_4.sql?project_id='||$project_id   AS link,
    'Heures de travail cumulées par séquence'                      AS description,
    'clock-24'                                     AS icon,
    'red'                                           AS color;

SELECT
    '/e_project_stats/stat_project_participant_stats2_display_4.sql?project_id='||$project_id   AS link,
    'Heures de travail cumulées par type de participant'                      AS description,
    'clock-24'                                     AS icon,
    'blue'                                         AS color;

SELECT
    '/e_project_stats/stat_project_participant_stats3_display_4.sql?project_id='||$project_id   AS link,
    'Télécharger  toutes les données'                      AS description,
    'download'                                     AS icon,
    'yellow'                                         AS color;
SELECT
    '/e_project_stats/stat_project_participant_stats4_display_4.sql?project_id='||$project_id   AS link,
    'Télécharger les données détaillées par participant'                      AS description,
    'download'                                     AS icon,
    'red'                                         AS color;
SELECT
    '/e_project_building_rooms_pictures/project_picture_gallery_4.sql?project_id='||$project_id   AS link,
    'Galerie photos'                                  AS description,
    'photo-search'                                     AS icon,
    'orange'                                           AS color;
SELECT
    '/e_project_building/building_location_display_4.sql?project_id='||$project_id   AS link,
    'Localisation des bâtiments'                      AS description,
    'map'                                     AS icon,
    'orange'                                           AS color;

SELECT 
    'datagrid'              AS component,
    'panel_hub_workspace_display' AS id,
    'GESTION DU PROJET: '||$project_name AS title;

SELECT 
    '/e_project_workpackage/workpackage_main_form0_4.sql?project_id='||$project_id       AS link,
    'Création d''un lot de travaux'                  AS description,
    'shovel-pitchforks'                                      AS icon,
    'yellow'                                         AS color;

SELECT 
    '/e_project_workpackage/workpackage_archive_display_4.sql?project_id='||$project_id             AS link,
    'Visualiser les slots de travaux achivées'           AS description,
    'archive'                                     AS icon,
    'green'                                              AS color;


SELECT 
    '/e_project_meeting/project_meeting_main_display_4.sql?project_id='||$project_id    AS link,
    'Réunions'                                    AS description,
    'calendar-time'                               AS icon,
    'red'                                         AS color;

SELECT
    '/e_project_forum/project_forum_main_display_4.sql?project_id='||$project_id   AS link,
    'Forum'                      AS description,
    'arrows-random'                             AS icon,
    'blue'                             AS color;

SELECT
    '/e_project_docs/project_doc_main_display_4.sql?project_id='||$project_id   AS link,
    'Documents'                      AS description,
    'book'                           AS icon,
    'yellow'                         AS color;

SELECT
    '/e_project_building/building_main_display_4.sql?project_id='||$project_id   AS link,
    'Bâtiments'                      AS description,
    'building'                       AS icon,
    'orange'                         AS color;

SELECT
    '/e_project_building_rooms_pictures/project_picture_display_4.sql?project_id='||$project_id   AS link,
    'Gestion des photos du projet'                    AS description,
    'photo-search'                                     AS icon,
    'orange'                                           AS color;

SELECT 
    'table'               AS component, 
    'Liste des lots de travaux rattachées au projet' AS title, 
    TRUE                  AS sort, 
    'View'                AS markdown,
    'Hub'                AS markdown,
    FALSE                 AS search;

SELECT
    workpackage_id            AS Id,
    '['||workpackage_name||'](/e_project_workpackage/workpackage_hub_display_4.sql?workpackage_id='||workpackage_id||')'         AS Hub,
    workpackage_type             AS Type,
    workpackage_mode             AS Mode,
    workpackage_rank             AS Rank,
'[Edit](/e_project_workpackage/workpackage_main_edit_4.sql?workpackage_id='||workpackage_id||
')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Delete](/e_project_workpackage/workpackage_main_delete_alert_4.sql?workpackage_id='||workpackage_id||')'  AS View
FROM project_workpackage
WHERE project_id = $project_id::INTEGER and workpackage_status='active'
ORDER BY workpackage_id ASC;

