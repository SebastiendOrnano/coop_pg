SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET project_name = SELECT project_name FROM project WHERE project_id=$project_id::INTEGER ;


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
    '/e_project/project_main_display_3.sql'     AS link;   

SELECT 
    'datagrid'              AS component,
    'panel_hub_workspace_display' AS id,
    'GESTION DU PROJET: '||$project_name AS title;

SELECT 
    '/e_project_workpackage/workpackage_main_form0_3.sql?project_id='||$project_id       AS link,
    'Création d''un lot de travaux'                  AS description,
    'shovel-pitchforks'                                      AS icon,
    'yellow'                                         AS color;

SELECT 
    '/e_project_meeting/project_meeting_main_display_3.sql?project_id='||$project_id    AS link,
    'Réunions'                                    AS description,
    'calendar-time'                               AS icon,
    'red'                                         AS color;

SELECT
    '/e_project_forum/project_forum_main_display_3.sql?project_id='||$project_id   AS link,
    'Forum'                      AS description,
    'arrows-random'                             AS icon,
    'blue'                             AS color;

SELECT
    '/e_project_docs/project_doc_main_display_3.sql?project_id='||$project_id   AS link,
    'Documents'                      AS description,
    'book'                           AS icon,
    'yellow'                         AS color;

SELECT
    '/e_project_building/building_main_display_3.sql?project_id='||$project_id   AS link,
    'Bâtiments'                      AS description,
    'building'                       AS icon,
    'orange'                         AS color;

SELECT
    '/e_project_building_rooms_pictures/project_picture_display_3.sql?project_id='||$project_id   AS link,
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
    '['||workpackage_name||'](/e_project_workpackage/workpackage_hub_display_3.sql?workpackage_id='||workpackage_id||')'         AS Hub,
    workpackage_type             AS Type,
    workpackage_mode             AS Mode,
    workpackage_rank             AS Rank,
'[Edit](/e_project_workpackage/workpackage_main_edit_3.sql?workpackage_id='||workpackage_id||')'  AS View
FROM project_workpackage
WHERE project_id = $project_id::INTEGER and workpackage_status='active'
ORDER BY workpackage_id ASC;

