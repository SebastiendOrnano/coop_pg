SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SELECT 
    'list'                 AS component,
    'Nos prochaines manifestions' AS title;

SELECT 
    CONCAT(
    e.event_date,'   à  ',e.event_start_hour,'  
## ',e.event_name,'     
',
p.place_adress,'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;',p.place_postal_code,'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;',p.place_town,'  
',event_summary
    )                                AS description_md,
    'calendar-check'                 AS icon,
    '/b_events/event_poster.sql?event_id='||e.event_id    AS link,
    '/b_events/event_poster.sql?event_id='||e.event_id    AS view_link
    FROM events AS e
     LEFT JOIN (SELECT place_id, space_name, space_id FROM place_spaces) AS s 
    ON s.space_id = e.space_id
    LEFT JOIN (SELECT place_adress, place_postal_code, place_town, place_id FROM place) AS p 
    ON p.place_id = s.place_id
    WHERE  e.event_name IS NOT NULL AND e.event_status ='active' AND e.event_public_private ='public' AND e.event_date > CURRENT_DATE;