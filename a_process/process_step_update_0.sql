
SET process_id= SELECT process_id FROM process_steps WHERE process_step_id=$process_step_id::INTEGER ;

UPDATE  process_steps
SET 
process_step_title=:process_step_title, 
process_step_number=:process_step_number::INTEGER , 
process_step_description=:process_step_description, 
process_step_icon=:process_step_icon, 
process_step_link=:process_step_link, 
updated_at = CURRENT_TIMESTAMP
WHERE process_step_id=$process_step_id::INTEGER 
 
RETURNING  'redirect' AS component,
'/a_process/process_step_display_5.sql?process_id='||$process_id  AS link;