DELETE FROM process_steps
WHERE process_id = $process_id::INTEGER 


DELETE FROM process
WHERE process_id = $process_id::INTEGER 
RETURNING
   'redirect' AS component,
   '/a_process/process_main_display_5.sql' AS link;