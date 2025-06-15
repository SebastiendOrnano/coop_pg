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
    'gestion des événements'            AS title,
    '/b_events/event_main_display_4.sql'     AS link;


SELECT 
    'divider'              AS component,
    'Liste des événements archivés' AS contents,
    'left'                 AS position,
    'black'                AS color;

-- Display list of organizations
SELECT 'table' AS component, 
    'Liste des événements archivés'   AS title, 
    'View'           AS markdown,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    e.event_id               AS Id,
    e.event_name             AS Nom,
    e.event_status           AS statut,
    e.event_date             AS Date,
    e.event_start_hour       AS heure,
    s.space_name             AS Salle,
   '[Particip](/b_events/event_registration_display_4.sql?event_id=' || e.event_id || ')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[View](/b_events/event_poster_4.sql?event_id=' || e.event_id || ')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Edit](/b_events/event_main_edit_4.sql?event_id=' || e.event_id || ')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Delete](/b_events/event_main_delete_alert_4.sql?event_id=' || e.event_id|| ')'    AS View
FROM events AS e
LEFT JOIN place_spaces AS s 
ON s.space_id = e.space_id
WHERE e.event_status ='archived'
ORDER BY e.event_date DESC;

