copy members
(
orga_dept_id,
member_gender,
member_first_name,
member_last_name,
member_phone,
member_email,
member_category,
member_function,
member_date_birthday,
member_date_since,
member_date_last_subscription,
member_punchline,
member_cv_short,
member_cv_long,
member_selected,
member_publish,
member_status
) 
FROM 'member_data_input'
WITH (FORMAT 'csv', HEADER true, DELIMITER ';', QUOTE '"',NULL '''');


SELECT 
    'alert'   AS component,
    'Success' AS title,
    'L''import semble s''etre bien passé. [revenir à la liste des membres](/b_orga_dept_members/orga_dept_member_main_display_4.sql?orga_dept_id='||$orga_dept_id)' AS description_md,
    'check'   AS icon,
    'green'   AS color;