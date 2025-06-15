DELETE FROM info_sections
WHERE section_id = $section_id::INTEGER 

RETURNING
'redirect' AS component,
'/a_info/section_main_display_5.sql' AS link;