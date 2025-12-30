UPDATE  rss
SET
rss_feed=:rss_feed,
rss_title=:rss_title,
rss_link=:rss_link,
rss_description=:rss_description, 
rss_category=:rss_category,
rss_status =:rss_status,
rss_item_title=:rss_item_title,
rss_item_link=:rss_item_link,
rss_item_table=:rss_item_table,
rss_item_description=:rss_item_description,
updated_at=CURRENT_TIMESTAMP

WHERE rss_id=$rss_id::INTEGER 
 
 RETURNING  'redirect' AS component,
'/a_rss/rss_main_display_5.sql' AS link;