DELETE FROM forum_messages WHERE topic_id = $topic_id::INTEGER ;

DELETE FROM forum_topics WHERE topic_id = $topic_id::INTEGER 
RETURNING
   'redirect' AS component,
   '/c_forum/forum_main_display_5.sql' AS link;