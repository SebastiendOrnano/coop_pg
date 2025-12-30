SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'alert'     AS component,
    'Validation du compte' AS title,
    'Le membre &nbsp;  '  || $member_last_name || ' &nbsp; a été créé !
    
[retour à la liste des membres](/b_orga_dept_members/orga_dept_member_main_display_4.sql?orga_dept_id='||$orga_dept_id )' AS description_md,
    'alert-triangle'            AS icon,
    'green'                AS color;



