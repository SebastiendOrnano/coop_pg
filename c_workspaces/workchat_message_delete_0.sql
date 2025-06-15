SET topic_id = SELECT topic_id FROM forum_messages WHERE message_id=$message_id::INTEGER;

DELETE FROM forum_messages 
WHERE message_id=$message_id::INTEGER

SELECT 'redirect' AS component,
'/c_workspaces/workchat_message_display_4.sql?topic_id='||$topic_id AS link;