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
    'Retour liste des événements'            AS title,
    '/b_events/event_main_display_4.sql'     AS link;


SELECT 
    'datagrid'              AS component,
    'panel_orga_display' AS id,
    'Gestion des particitpants de l''événement' AS title;

SELECT 
     '/b_events/event_participants_csv_email_0.sql?event_id='||$event_id    AS link,
    'Télécharger la liste des participants'                                AS description,
    'users-group'                                                          AS icon,
    'blue'                                                                 AS color;

SET lieu = (
    SELECT s.space_name
FROM events e
LEFT JOIN place_spaces s ON s.space_id = e.space_id
WHERE e.event_id = $event_id::INTEGER
);

SET adress = (
    SELECT CONCAT(p.place_adress, '       
', p.place_postal_code, '     ', p.place_town)
    FROM events as e
    LEFT JOIN (SELECT space_id, place_id FROM place_spaces) as s 
    ON s.space_id = e.space_id
    LEFT JOIN (SELECT place_id, place_adress, place_postal_code, place_town FROM place) as p
    ON p.place_id = s.place_id
    WHERE e.event_id = $event_id::INTEGER
);

SET place_id = SELECT p.place_id 
    FROM events as e
    LEFT JOIN (SELECT space_id, place_id FROM place_spaces) as s 
    ON s.space_id = e.space_id
    LEFT JOIN (SELECT place_id FROM place) as p
    ON p.place_id = s.place_id
    WHERE e.event_id = $event_id::INTEGER;

SELECT
    'title' AS component,
    TRUE AS center,
    (SELECT event_name FROM events WHERE event_id=$event_id::INTEGER) AS contents;

SELECT
    'text' AS component,
    'event_place' AS id,
     $lieu||'  
'||$adress AS contents_md;

SELECT
    'text' AS component,
     '**DATE** :  '||(SELECT event_date FROM events WHERE event_id = $event_id::INTEGER ) AS contents_md;

-- Display list of organizations
SELECT 'table' AS component, 
    'Liste des événements'   AS title, 
    'View'           AS markdown,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    participant_id                     AS Id,
    participant_first_name             AS Prénom,
    participant_last_name               AS Nom,
    participant_function                 AS Fonction,
    participant_contact_email            AS Mail
FROM event_participants
WHERE event_id=$event_id::INTEGER
ORDER BY created_at ASC;
