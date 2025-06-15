SET topic_id=(SELECT topic_id FROM forum_messages WHERE message_id=$message_id::INTEGER );


UPDATE forum_messages
SET
message_status='closed',
updated_at=CURRENT_TIMESTAMP
WHERE message_id=$message_id::INTEGER 

RETURNING 
'redirect' AS component, 
'/c_debug/debug_message_display_5.sql?topic_id='||$topic_id AS link;