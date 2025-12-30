SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor_3.sql' AS link;
SELECT 
    'Retour liste des événements'            AS title,
    '/b_events/event_main_display_3.sql'     AS link;


SELECT
    'text' AS component,
    CASE
    WHEN (SELECT event_picture_url FROM events WHERE event_id = $event_id::INTEGER) IS NULL OR (SELECT event_picture_url FROM events WHERE event_id = $event_id::INTEGER) ='' THEN ''
    ELSE '![Affiche]('||(SELECT event_picture_url FROM events WHERE event_id = $event_id::INTEGER )||')' END AS contents_md;

SELECT
    'title' AS component,
    TRUE AS center,
    (SELECT event_name FROM events WHERE event_id=$event_id::INTEGER) AS contents;

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
    'divider'            AS component,
    'Lieu'               AS contents,
    'blue'               AS color,
    5                    AS size,
    TRUE                 AS bold,
    'left'               AS position;

SELECT
    'text' AS component,
    'event_place' AS id,
     $lieu||'  
'||$adress AS contents_md;


SELECT
    'text' AS component,
    '[**Repérer le lieu sur une carte**](/b_events/event_map.sql?place_id='||$place_id||'&event_id='||$event_id||')' AS contents_md;
 
SET program = 
CASE 
WHEN (SELECT event_program_url ='' OR event_program_url IS NULL FROM events WHERE event_id = $event_id::INTEGER) THEN ''
ELSE 'Découvrir le programme complet-> [Programme]('||(SELECT event_program_url FROM events WHERE event_id = $event_id::INTEGER)||')'
END;

SELECT 
    'divider'            AS component,
    'Présentation'               AS contents,
    'blue'               AS color,
    5                    AS size,
    TRUE                 AS bold,
    'left'               AS position;

SELECT
    'text' AS component,
   (SELECT event_summary FROM events WHERE event_id = $event_id::INTEGER)||'  

'||$program AS contents_md;

SELECT 
    'divider'            AS component,
    'Infos pratiques'    AS contents,
    'blue'               AS color,
    5                    AS size,
    TRUE                 AS bold,
    'left'               AS position;

SELECT
    'text' AS component,
     '**DATE** :  '||(SELECT event_date FROM events WHERE event_id = $event_id::INTEGER) AS contents_md;

SELECT
    'text' AS component,
    '**HEURE DÉBUT** :  '||(SELECT event_start_hour FROM events WHERE event_id = $event_id::INTEGER) AS contents_md;

SET event_audience_target = 
CASE 
WHEN (SELECT event_audience_target ='' OR event_audience_target IS NULL FROM events WHERE event_id = $event_id::INTEGER) THEN ''
ELSE '**PUBLIC CONCERNÉ** :  '||(SELECT event_audience_target FROM events WHERE event_id = $event_id::INTEGER)
END;

SELECT
    'text' AS component,
    $event_audience_target AS contents_md;

SET nb_max_participants = 
CASE 
WHEN (SELECT event_participants_nb_max IS NULL FROM events WHERE event_id = $event_id::INTEGER) THEN ''
ELSE '**Nb MAX DE PARTICIPANTS** :  '||(SELECT event_participants_nb_max FROM events WHERE event_id = $event_id::INTEGER)
END;

SELECT
    'text' AS component,
    $nb_max_participants AS contents_md;

SET registration = 
CASE 
WHEN (SELECT event_registration =false OR event_registration IS NULL FROM events WHERE event_id = $event_id::INTEGER) THEN ''
ELSE '**RÉSERVATION OBLIGATOIRE ->**  [s''inscrire](/b_events/event_registration_form.sql?event_id='||$event_id||')'
END;

SELECT
    'text' AS component,
    $registration AS contents_md;

SET entrance_fee = 
CASE 
WHEN (SELECT event_entrance_fee  IS NULL FROM events WHERE event_id = $event_id::INTEGER) THEN '**ENTRÉE GRATUITE**'
ELSE '**PRIX ''ENTRÉE** :  '||(SELECT event_entrance_fee FROM events WHERE event_id = $event_id::INTEGER)
END;

SELECT
    'text' AS component,
    $entrance_fee AS contents_md;



SELECT
    'text' AS component,
    'Nb de participants : '||$participants AS contents_md;


SELECT 
    'datagrid'              AS component,
    'panel_orga_display' AS id,
    'Gestion des participants de l''événement' AS title;

SELECT 
     '/b_events/event_participants_csv_email_0.sql?event_id='||$event_id    AS link,
    'Télécharger la liste des participants'                                AS description,
    'users-group'                                                          AS icon,
    'blue'                                                                 AS color;

SET nb_max_participants = 
CASE 
WHEN (SELECT event_participants_nb_max IS NULL FROM events WHERE event_id = $event_id::INTEGER ) THEN NULL
ELSE (SELECT event_participants_nb_max FROM events WHERE event_id = $event_id::INTEGER)
END

SET participants = 
CASE 
WHEN (SELECT event_participants_nb IS NULL FROM events WHERE event_id = $event_id::INTEGER) THEN '0'
ELSE (SELECT event_participants_nb FROM events WHERE event_id = $event_id::INTEGER)
END;

SELECT 'form' as component,
       '' as validate;
SELECT
    'text' AS type,
    'Nb max de partcipants' as label,
    3 as width,
    true as readonly,
    $nb_max_participants AS value;

SELECT
    'text' AS type,
    'Nb de partcipants' as label,
    3 as width,
    true as readonly,
   $participants AS value;

-- Display list of organizations
SELECT 'table' AS component, 
    'Liste des participants'   AS title, 
    'View'           AS markdown,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    participant_id                  AS Id,
    participant_first_name          AS Prénom,
    participant_last_name           AS Nom,
    participant_age                 AS Age,
    participant_contact_email        AS Mail,
   '[Remove](/b_events/event_main_remove_0.sql?participant_id=' || participant_id|| ')'    AS View
FROM event_participants
WHERE event_id=$event_id::INTEGER
ORDER BY created_at ASC;
