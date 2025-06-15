
DELETE FROM events
WHERE event_id  = $event_id::INTEGER

RETURNING
'redirect' AS component,
'/b_events/event_main_display_4.sql' AS link;