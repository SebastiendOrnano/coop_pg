SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_1.sql') AS properties;


SELECT 
    'alert'                    as component,
    'Actualisation d''une sélection d''employée' as title,
    'analyze'                  as icon,
    'teal'                     as color,
    'Vous n''avez sélectionner aucun employé !' as description; 

SELECT 
    '/d_prm2_sub_employees/prm2_sub_employee_select_no_0.sql?prm2_sub_id='||$prm2_sub_id||'&prm2_id='||$prm2_id   as link,
    'Retour à la liste' as title,
    'green'    as color;




