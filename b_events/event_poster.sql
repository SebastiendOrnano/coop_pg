SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;

SELECT 
     'Retour à l''agenda'            AS title,
    '/b_events/event_main_list.sql' AS link;

SELECT
    'text' AS component,
    CASE
    WHEN (SELECT event_picture_url FROM events WHERE event_id = $event_id::INTEGER) IS NULL OR (SELECT event_picture_url FROM events WHERE event_id = $event_id::INTEGER) ='' THEN ''
    ELSE '![Affiche]('||(SELECT event_picture_url FROM events WHERE event_id = $event_id::INTEGER )||')' END AS contents_md;

SELECT
    'title' AS component,
    TRUE AS center,
    (SELECT event_name FROM events WHERE event_id=$event_id::INTEGER) AS contents;


SET place_id = SELECT p.place_id 
    FROM events as e
    LEFT JOIN (SELECT space_id, place_id FROM place_spaces) as s 
    ON s.space_id = e.space_id
    LEFT JOIN (SELECT place_id FROM place) as p
    ON p.place_id = s.place_id
    WHERE e.event_id = $event_id::INTEGER;


SET lieu = 
CASE 
WHEN (SELECT s.space_rank FROM events AS e LEFT JOIN place_spaces AS s ON s.space_id = e.space_id WHERE e.event_id = $event_id::INTEGER) ='main'
THEN (SELECT s.space_name FROM events AS e LEFT JOIN place_spaces AS s ON s.space_id = e.space_id WHERE e.event_id = $event_id::INTEGER)
WHEN (SELECT s.space_rank FROM events AS e LEFT JOIN place_spaces AS s ON s.space_id = e.space_id WHERE e.event_id = $event_id::INTEGER) !='main'
THEN (SELECT p.place_name FROM events AS e 
   LEFT JOIN (SELECT space_id, place_id, space_name FROM place_spaces) as s 
    ON s.space_id = e.space_id
    LEFT JOIN (SELECT place_id, place_name FROM place) as p
    ON p.place_id = s.place_id
WHERE e.event_id = $event_id::INTEGER) || ' 
  
salle :   '|| ( SELECT s.space_name FROM events AS e LEFT JOIN place_spaces AS s ON s.space_id = e.space_id WHERE e.event_id = $event_id::INTEGER)||'  
'
END

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
END

SELECT 
    'divider'            AS component,
    'Présentation'               AS contents,
    'blue'               AS color,
    5                    AS size,
    TRUE                 AS bold,
    'left'               AS position;

SELECT
    'text' AS component,
    'presentation' AS id,
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
WHEN (SELECT event_audience_target ='' OR event_audience_target IS NULL FROM events WHERE event_id = $event_id::INTEGER ) THEN ''
ELSE '**PUBLIC CONCERNÉ** :  '||(SELECT event_audience_target FROM events WHERE event_id = $event_id::INTEGER)
END

SELECT
    'text' AS component,
    $event_audience_target AS contents_md;

SELECT 
    'divider'            AS component,
    'Inscription'    AS contents,
    'blue'               AS color,
    5                    AS size,
    TRUE                 AS bold,
    'left'               AS position;



SET nb_max_participants = 
CASE 
WHEN (SELECT event_participants_nb_max IS NULL FROM events WHERE event_id = $event_id::INTEGER ) THEN ''
ELSE '**Nb MAX DE PARTICIPANTS** :  '||(SELECT event_participants_nb_max FROM events WHERE event_id = $event_id::INTEGER)
END

SELECT
    'text' AS component,
    $nb_max_participants AS contents_md;

SET registration = 
CASE 
WHEN (SELECT event_registration =false OR event_registration IS NULL FROM events WHERE event_id = $event_id::INTEGER ) THEN ''
WHEN (SELECT event_participants_nb = event_participants_nb_max FROM events WHERE event_id = $event_id::INTEGER ) THEN '***COMPLET Il n''est plus possible de s''inscrire ! Désolé***'
ELSE '**RÉSERVATION OBLIGATOIRE ->**  [s''inscrire](/b_events/event_registration_form.sql?event_id='||$event_id||')'
END

SELECT
    'text' AS component,
    $registration AS contents_md;

SET entrance_fee = 
CASE 
WHEN (SELECT  event_entrance_fee IS NULL FROM events WHERE event_id = $event_id::INTEGER ) THEN '**ENTRÉE GRATUITE**'
ELSE '**PRIX ''ENTRÉE** :  '||(SELECT event_entrance_fee FROM events WHERE event_id = $event_id::INTEGER)
END

SELECT
    'text' AS component,
    $entrance_fee||'  euros' AS contents_md;


