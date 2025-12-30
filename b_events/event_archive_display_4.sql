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
    JSON('{"name":"View","tooltip":"View & Partcipants","link":"/b_events/event_poster_4.sql?event_id={id}","icon":"user-circle"}') as custom_actions,
    '/b_events/event_main_edit_4.sql?event_id={id}' as edit_url,
    '/b_events/event_main_delete_alert_4.sql?event_id={id}' as delete_url,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    e.event_id               AS Id,
    e.event_id              as _sqlpage_id,
    e.event_name             AS Nom,
    e.event_public_private           AS PublicPrivé,
    e.event_status           AS statut,
    e.event_date             AS Date,
    e.event_start_hour       AS heure,
    s.space_name             AS Salle,
    e.event_participants_nb          AS NB_inscrits
FROM events AS e
LEFT JOIN place_spaces AS s 
ON s.space_id = e.space_id
WHERE e.event_status ='archived'
ORDER BY e.event_date DESC;

