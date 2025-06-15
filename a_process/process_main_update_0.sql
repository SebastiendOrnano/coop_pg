UPDATE process
SET
process_title=:process_title,
process_description= :process_description,
process_category =:process_category,
process_status = :process_status,
updated_at=CURRENT_TIMESTAMP

WHERE process_id=$process_id::INTEGER 
 
RETURNING  'redirect' AS component,
'/a_process/process_main_display_5.sql' AS link;