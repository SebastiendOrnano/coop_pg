DELETE FROM rss
WHERE rss_id=$rss_id::INTEGER 
 
 RETURNING  'redirect' AS component,
'/a_rss/rss_main_display_5.sql' AS link;