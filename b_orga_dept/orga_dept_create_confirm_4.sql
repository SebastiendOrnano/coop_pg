SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'alert'     AS component,
    'check'   AS icon,
    'Confirmation de la création d''une filiale ou un départment' AS title,
    'L''organisation &nbsp; &nbsp; : &nbsp;**' || (SELECT orga_dept_name FROM orga_dept WHERE orga_dept_id=$orga_dept_id) || '**&nbsp;&nbsp;filiale ou département de &nbsp;&nbsp; ***' || (SELECT orga_name FROM orga WHERE orga_id=$orga_dept_id) ||'***&nbsp;&nbsp; a été créé !  
    [retour à la liste des organisations](/b_orga/orga_display_4.sql)' AS description_md,
    'green'                AS color;



