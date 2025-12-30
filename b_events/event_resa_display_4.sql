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
    'datagrid'              AS component,
    'panel_orga_display' AS id,
    'Gestion des événements' AS title;

SELECT 
    '/b_events/event_main_form_4.sql'               AS link,
    'Création d''un nouvel événement'               AS description,
    'confetti'                                      AS icon,
    'yellow'                                        AS color;

SELECT 
    '/b_events/event_main_list.sql'                   AS link,
    'Liste des événements'                            AS description,
    'users-group'                                     AS icon,
    'blue'                                            AS color;

SELECT 
    '/b_events/event_archive_display_4.sql'             AS link,
    'Visualiser les événements achivées'                AS description,
    'archive'                                           AS icon,
    'red'                                               AS color;

SELECT 
    '/b_events/event_past_display_4.sql'             AS link,
    'Visualiser les événements terminés'             AS description,
    'calendar-clock'                                 AS icon,
    'green'                                          AS color;

SELECT 
    'divider'              AS component,
    'Vérif occupation des salles' AS contents,
    'left'                 AS position,
    'black'                AS color;

-- Display list of organizations
SELECT 'table' AS component, 
    'Liste des événements à venir'   AS title, 
    'View'           AS markdown,
    JSON('{"name":"View","tooltip":"View & Partcipants","link":"/b_events/event_poster_4.sql?event_id={id}","icon":"user-circle"}') as custom_actions,
    '/b_events/event_main_edit_4.sql?event_id={id}' as edit_url,
    '/b_events/event_main_delete_alert_4.sql?event_id={id}' as delete_url,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    s.space_name             AS Salle,
    e.event_date             AS Date,
    e.event_start_hour       AS heure,
    e.event_id               AS Id,
    e.event_name             AS Nom,
    e.event_status           AS statut,
    e.event_public_private   AS PublicPrivate
FROM events AS e
LEFT JOIN (SELECT space_id, space_name FROM place_spaces) AS s 
ON s.space_id = e.space_id
WHERE e.event_name IS NOT NULL AND e.event_status !='archived' AND e.event_date > CURRENT_DATE
ORDER BY s.space_name DESC;

