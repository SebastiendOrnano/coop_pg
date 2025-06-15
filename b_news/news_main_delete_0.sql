
DELETE FROM news
WHERE news_id  = $news_id::INTEGER

RETURNING
'redirect' AS component,
'/b_news/news_main_display_4.sql' AS link;