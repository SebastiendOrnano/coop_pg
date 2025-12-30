SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'alert'     AS component,
    'Validation du compte' AS title,
    'Le membre &nbsp;  '  || $member_last_name || ' &nbsp; a été créé !
    
[retour à la liste des membres](/b_members/member_main_display_4.sql)' AS description_md,
    'alert-triangle'            AS icon,
    'green'                AS color;



