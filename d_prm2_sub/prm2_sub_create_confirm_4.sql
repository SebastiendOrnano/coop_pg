SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'alert'     as component,
    'check'   as icon,
    'Confirmation de la création d''une filiale ou un départment' as title,
    'L''organisation &nbsp; &nbsp; : &nbsp;**' || (SELECT prm2_sub_name FROM prm2_sub WHERE prm2_sub_id = $prm2_sub_id::INTEGER) || '**&nbsp;&nbsp;filiale ou département de &nbsp;&nbsp; ***' || (SELECT prm2_name FROM prm2 WHERE prm2_id = $prm2_sub_id::INTEGER) ||'***&nbsp;&nbsp; a été créé !  
    [retour à la liste des organisations](/d_prm2/prm2_display_4.sql)' as description_md,
    'green'                as color;



